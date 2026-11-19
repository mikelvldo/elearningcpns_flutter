import 'dart:async';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../app/routes/app_routes.dart';
import '../../core/services/local_storage_service.dart';
import '../../core/utils/youtube_error.dart';
import '../../data/models/course.dart';
import '../../data/models/last_learning.dart';
import '../../data/models/lesson.dart';
import 'player_args.dart';

class PlayerViewModel extends GetxController {
  PlayerViewModel(this._localStorage);

  final LocalStorageService _localStorage;

  late final PlayerArgs _args = Get.arguments as PlayerArgs;

  Course get course => _args.course;

  final currentIndex = 0.obs;
  Lesson get lesson => course.lessons[currentIndex.value];
  bool get hasPrevious => currentIndex.value > 0;
  bool get hasNext => currentIndex.value < course.lessons.length - 1;

  late final YoutubePlayerController youtube;

  final isReady = false.obs;
  final errorMessage = RxnString();

  /// True bila error karena pemilik video melarang diputar di aplikasi lain.
  final canOpenExternally = false.obs;

  /// Umpan balik double tap: sisi (-1 kiri, 1 kanan, 0 tidak aktif) dan total detik.
  final seekSide = 0.obs;
  final seekTotal = 0.obs;

  Timer? _loadTimeout;
  Timer? _seekTimer;
  int? _pendingSeekTarget;
  int _lastSavedSecond = 0;
  bool _endedHandled = false;

  @override
  void onInit() {
    super.onInit();
    currentIndex.value = _args.lessonIndex;

    final startAt = _savedPositionFor(lesson);
    youtube = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(lesson.videoUrl) ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        startAt: startAt,
        enableCaption: true,
        forceHD: false,
      ),
    );
    youtube.addListener(_onPlayerChanged);

    _saveProgress(startAt);
    _startLoadTimeout();
  }

  // ------------------------------------------------------------ Listener

  void _onPlayerChanged() {
    final value = youtube.value;

    if (value.isReady && !isReady.value) {
      isReady.value = true;
      _loadTimeout?.cancel();
    }

    if (value.hasError) {
      _loadTimeout?.cancel();
      errorMessage.value = youtubeErrorMessage(value.errorCode);
      canOpenExternally.value = isEmbedBlocked(value.errorCode);
      return;
    }

    // Simpan posisi tiap ~5 detik selama video berjalan.
    final seconds = value.position.inSeconds;
    if (value.isPlaying && (seconds - _lastSavedSecond).abs() >= 5) {
      _saveProgress(seconds);
    }

    // Lesson selesai -> otomatis lanjut ke lesson berikutnya.
    if (value.playerState == PlayerState.ended) {
      if (!_endedHandled) {
        _endedHandled = true;
        if (hasNext) selectLesson(currentIndex.value + 1);
      }
    } else {
      _endedHandled = false;
    }
  }

  /// Jika player tidak siap dalam 15 detik, anggap koneksi bermasalah.
  void _startLoadTimeout() {
    _loadTimeout?.cancel();
    _loadTimeout = Timer(const Duration(seconds: 15), () {
      if (!isReady.value && errorMessage.value == null) {
        errorMessage.value =
            'Video tidak dapat dimuat. Periksa koneksi internet lalu coba lagi.';
        canOpenExternally.value = false;
      }
    });
  }

  // ------------------------------------------------------------- Aksi

  void selectLesson(int index) {
    if (index < 0 || index >= course.lessons.length) return;
    if (index == currentIndex.value && errorMessage.value == null) return;

    currentIndex.value = index;
    errorMessage.value = null;
    canOpenExternally.value = false;

    final id = YoutubePlayer.convertUrlToId(lesson.videoUrl);
    if (id == null) {
      errorMessage.value = 'Link video tidak valid.';
      return;
    }
    final startAt = _savedPositionFor(lesson);
    youtube.load(id, startAt: startAt);
    _saveProgress(startAt);
    if (!isReady.value) _startLoadTimeout();
  }

  /// Loncat maju (+) atau mundur (-) beberapa detik. Tap beruntun menumpuk.
  void seekBy(int seconds) {
    final value = youtube.value;
    if (!value.isReady) return;

    final duration = value.metaData.duration.inSeconds;
    var target = (_pendingSeekTarget ?? value.position.inSeconds) + seconds;
    if (target < 0) target = 0;
    if (duration > 0 && target > duration - 1) target = duration - 1;

    _pendingSeekTarget = target;
    youtube.seekTo(Duration(seconds: target));

    final side = seconds > 0 ? 1 : -1;
    seekTotal.value =
        seekSide.value == side ? seekTotal.value + seconds.abs() : seconds.abs();
    seekSide.value = side;

    _seekTimer?.cancel();
    _seekTimer = Timer(const Duration(milliseconds: 700), () {
      seekSide.value = 0;
      seekTotal.value = 0;
      _pendingSeekTarget = null;
    });
  }

  void togglePlay() {
    if (youtube.value.isPlaying) {
      youtube.pause();
    } else {
      youtube.play();
    }
  }

  void previous() => selectLesson(currentIndex.value - 1);
  void next() => selectLesson(currentIndex.value + 1);

  void retry() {
    errorMessage.value = null;
    canOpenExternally.value = false;
    final id = YoutubePlayer.convertUrlToId(lesson.videoUrl);
    if (id == null) {
      errorMessage.value = 'Link video tidak valid.';
      return;
    }
    youtube.load(id, startAt: _savedPositionFor(lesson));
    if (!isReady.value) _startLoadTimeout();
  }

  Future<void> openInYoutube() async {
    try {
      await launchUrl(
        Uri.parse(lesson.videoUrl),
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {
      Get.snackbar('Gagal', 'Tidak dapat membuka aplikasi YouTube.');
    }
  }

  /// Kembali ke daftar course (Home).
  void goToCourseList() {
    Get.until((route) => route.settings.name == Routes.home);
  }

  // ------------------------------------------------------ Log belajar

  int _savedPositionFor(Lesson lesson) {
    final last = _localStorage.lastLearning;
    if (last != null &&
        last.courseId == course.id &&
        last.lessonId == lesson.id) {
      return last.positionSeconds;
    }
    return 0;
  }

  void _saveProgress(int seconds) {
    _lastSavedSecond = seconds;
    _localStorage.saveLastLearning(
      LastLearning(
        courseId: course.id,
        lessonId: lesson.id,
        positionSeconds: seconds,
        updatedAt: DateTime.now(),
      ),
    );
  }

  // ------------------------------------------------------------ Dispose

  @override
  void onClose() {
    _loadTimeout?.cancel();
    _seekTimer?.cancel();
    try {
      if (youtube.value.isReady) {
        _saveProgress(youtube.value.position.inSeconds);
      }
      youtube.removeListener(_onPlayerChanged);
      youtube.dispose();
    } catch (_) {
      // Controller sudah dilepas oleh widget; abaikan.
    }
    super.onClose();
  }
}

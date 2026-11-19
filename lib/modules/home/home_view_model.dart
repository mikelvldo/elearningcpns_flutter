import 'dart:typed_data';

import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../core/services/local_storage_service.dart';
import '../../core/services/secure_storage_service.dart';
import '../../core/services/thumbnail_service.dart';
import '../../data/models/course.dart';
import '../../data/models/lesson.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/course_repository.dart';
import '../player/player_args.dart';

/// Info untuk kartu "Lanjutkan belajar".
class ContinueInfo {
  const ContinueInfo({required this.course, required this.lesson});
  final Course course;
  final Lesson lesson;
}

class HomeViewModel extends GetxController {
  HomeViewModel(
    this._courseRepository,
    this._secureStorage,
    this._thumbnailService,
    this._localStorage,
    this._authRepository,
  );

  final CourseRepository _courseRepository;
  final SecureStorageService _secureStorage;
  final ThumbnailService _thumbnailService;
  final LocalStorageService _localStorage;
  final AuthRepository _authRepository;

  final courses = <Course>[].obs;
  final isLoading = true.obs;
  final errorMessage = RxnString();

  /// Thumbnail per course id (diambil dari video lesson pertama).
  final thumbnails = <String, Uint8List>{}.obs;
  final continueInfo = Rxn<ContinueInfo>();

  int get totalLessons =>
      courses.fold(0, (sum, course) => sum + course.lessons.length);

  @override
  void onInit() {
    super.onInit();
    loadCourses();
  }

  Future<void> loadCourses() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final result = await _courseRepository.getCourses();

      // Isi dulu dari cache SharedPreferences agar gambar langsung tampil.
      for (final course in result) {
        final cached = _thumbnailService.getCached(course.thumbnailVideoUrl);
        if (cached != null) thumbnails[course.id] = cached;
      }
      courses.assignAll(result);
      refreshContinue();
    } catch (_) {
      errorMessage.value = 'Gagal memuat course. Periksa koneksi lalu coba lagi.';
    } finally {
      isLoading.value = false;
    }

    // Unduh thumbnail yang belum ada di cache (di latar belakang).
    for (final course in courses) {
      if (!thumbnails.containsKey(course.id)) {
        _fetchThumbnail(course);
      }
    }
  }

  Future<void> _fetchThumbnail(Course course) async {
    final bytes = await _thumbnailService.getThumbnail(course.thumbnailVideoUrl);
    if (bytes != null) thumbnails[course.id] = bytes;
  }

  void refreshContinue() {
    final last = _localStorage.lastLearning;
    if (last == null) {
      continueInfo.value = null;
      return;
    }
    for (final course in courses) {
      if (course.id != last.courseId) continue;
      for (final lesson in course.lessons) {
        if (lesson.id == last.lessonId) {
          continueInfo.value = ContinueInfo(course: course, lesson: lesson);
          return;
        }
      }
    }
    continueInfo.value = null;
  }

  Future<void> openCourse(Course course) async {
    await Get.toNamed(Routes.courseDetail, arguments: course);
    refreshContinue(); // log belajar bisa berubah di halaman detail
  }

  /// Lanjutkan belajar: langsung memutar lesson terakhir dari posisi tersimpan.
  Future<void> continueLearning(ContinueInfo info) async {
    final index = info.course.lessons.indexWhere((l) => l.id == info.lesson.id);
    await Get.toNamed(
      Routes.player,
      arguments: PlayerArgs(
        course: info.course,
        lessonIndex: index < 0 ? 0 : index,
      ),
    );
    refreshContinue();
  }

  Future<void> logout() async {
    await _authRepository.logout();
    await _secureStorage.deleteToken();
    Get.offAllNamed(Routes.login);
  }
}

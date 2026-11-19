import 'dart:typed_data';

import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../core/services/local_storage_service.dart';
import '../../core/services/thumbnail_service.dart';
import '../../data/models/course.dart';
import '../../data/models/lesson.dart';
import '../player/player_args.dart';

class CourseDetailViewModel extends GetxController {
  CourseDetailViewModel(this._thumbnailService, this._localStorage);

  final ThumbnailService _thumbnailService;
  final LocalStorageService _localStorage;

  /// Dikirim dari Home lewat Get.toNamed(arguments: course).
  late final Course course = Get.arguments as Course;

  final thumbnail = Rxn<Uint8List>();
  final lastLessonId = RxnString();

  @override
  void onInit() {
    super.onInit();

    final last = _localStorage.lastLearning;
    if (last != null && last.courseId == course.id) {
      lastLessonId.value = last.lessonId;
    }

    // Cache dulu (instan), lalu unduh bila belum ada.
    thumbnail.value = _thumbnailService.getCached(course.thumbnailVideoUrl);
    if (thumbnail.value == null) _loadThumbnail();
  }

  Future<void> _loadThumbnail() async {
    thumbnail.value = await _thumbnailService.getThumbnail(course.thumbnailVideoUrl);
  }

  /// Memilih lesson: buka pemutar video. Setelah kembali, perbarui penanda
  /// "Terakhir dibuka".
  Future<void> openLesson(Lesson lesson) async {
    final index = course.lessons.indexWhere((l) => l.id == lesson.id);
    await Get.toNamed(
      Routes.player,
      arguments: PlayerArgs(course: course, lessonIndex: index < 0 ? 0 : index),
    );

    final last = _localStorage.lastLearning;
    if (last != null && last.courseId == course.id) {
      lastLessonId.value = last.lessonId;
    }
  }
}

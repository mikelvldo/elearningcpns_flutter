import '../../data/models/course.dart';

/// Argumen untuk membuka halaman pemutar video.
class PlayerArgs {
  const PlayerArgs({required this.course, required this.lessonIndex});

  final Course course;
  final int lessonIndex;
}

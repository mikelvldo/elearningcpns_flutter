import 'lesson.dart';

class Course {
  const Course({
    required this.id,
    required this.title,
    required this.summary,
    required this.description,
    required this.instructor,
    required this.category,
    required this.level,
    required this.lessons,
  });

  final String id;
  final String title;
  final String summary;
  final String description;
  final String instructor;
  final String category;
  final String level;
  final List<Lesson> lessons;

  /// Thumbnail course diambil dari video lesson pertama.
  String? get thumbnailVideoUrl =>
      lessons.isEmpty ? null : lessons.first.videoUrl;

  int get totalDurationSeconds =>
      lessons.fold(0, (sum, lesson) => sum + lesson.durationSeconds);

  factory Course.fromJson(Map<String, dynamic> json) {
    final lessons = (json['lessons'] as List<dynamic>)
        .map((e) => Lesson.fromJson(e as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));

    return Course(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      description: json['description'] as String,
      instructor: json['instructor'] as String,
      category: json['category'] as String,
      level: json['level'] as String,
      lessons: lessons,
    );
  }
}

/// Log terakhir belajar: sampai course/lesson mana dan posisi videonya.
class LastLearning {
  const LastLearning({
    required this.courseId,
    required this.lessonId,
    this.positionSeconds = 0,
    required this.updatedAt,
  });

  final String courseId;
  final String lessonId;
  final int positionSeconds;
  final DateTime updatedAt;

  factory LastLearning.fromJson(Map<String, dynamic> json) => LastLearning(
        courseId: json['course_id'] as String,
        lessonId: json['lesson_id'] as String,
        positionSeconds: json['position_seconds'] as int? ?? 0,
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'course_id': courseId,
        'lesson_id': lessonId,
        'position_seconds': positionSeconds,
        'updated_at': updatedAt.toIso8601String(),
      };
}

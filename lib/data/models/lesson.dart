class Lesson {
  const Lesson({
    required this.id,
    required this.order,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.durationSeconds,
  });

  final String id;
  final int order;
  final String title;
  final String description;
  final String videoUrl;
  final int durationSeconds;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json['id'] as String,
        order: json['order'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        videoUrl: json['video_url'] as String,
        durationSeconds: json['duration_seconds'] as int,
      );
}

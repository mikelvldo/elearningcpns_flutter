/// Nama koleksi & field Firestore (satu tempat agar tidak ada typo string).
///
/// Struktur database:
///
///   categories/{categoryId}            name
///   instructors/{instructorId}         name
///   courses/{courseId}                 title, summary, description, level,
///                                      category_id, category_name,
///                                      instructor_id, instructor_name,
///                                      lesson_count, total_duration_seconds,
///                                      sort_order, updated_at
///     lessons/{lessonId}  (subkoleksi) order, title, description,
///                                      video_url, duration_seconds
///   users/{uid}                        name, email, role, updated_at
///
/// `category_name` dan `instructor_name` di dokumen course sengaja disalin
/// (denormalisasi): Firestore tidak punya JOIN, dan layar daftar course
/// cukup dengan 1 query.
class FirestorePaths {
  FirestorePaths._();

  static const categories = 'categories';
  static const instructors = 'instructors';
  static const courses = 'courses';
  static const lessons = 'lessons'; // subkoleksi di dalam courses/{id}
  static const users = 'users';
}

class FirestoreFields {
  FirestoreFields._();

  // Umum
  static const name = 'name';
  static const updatedAt = 'updated_at';

  // Course
  static const title = 'title';
  static const summary = 'summary';
  static const description = 'description';
  static const level = 'level';
  static const categoryId = 'category_id';
  static const categoryName = 'category_name';
  static const instructorId = 'instructor_id';
  static const instructorName = 'instructor_name';
  static const lessonCount = 'lesson_count';
  static const totalDurationSeconds = 'total_duration_seconds';
  static const sortOrder = 'sort_order';

  // Lesson
  static const order = 'order';
  static const videoUrl = 'video_url';
  static const durationSeconds = 'duration_seconds';

  // User
  static const email = 'email';
  static const role = 'role';
}

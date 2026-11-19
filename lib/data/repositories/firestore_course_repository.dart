import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constants/firestore_paths.dart';
import '../models/course.dart';
import 'course_repository.dart';

/// Membaca course dari Firestore:
/// courses (diurutkan sort_order) + subkoleksi lessons (diurutkan order).
class FirestoreCourseRepository implements CourseRepository {
  FirestoreCourseRepository([FirebaseFirestore? firestore])
      : _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  @override
  Future<List<Course>> getCourses() async {
    final snapshot = await _db
        .collection(FirestorePaths.courses)
        .orderBy(FirestoreFields.sortOrder)
        .get();

    // Lesson tiap course diambil paralel.
    return Future.wait(snapshot.docs.map(_toCourse));
  }

  Future<Course> _toCourse(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) async {
    final lessonSnapshot = await doc.reference
        .collection(FirestorePaths.lessons)
        .orderBy(FirestoreFields.order)
        .get();

    final data = doc.data();
    return Course.fromJson({
      'id': doc.id,
      'title': data[FirestoreFields.title],
      'summary': data[FirestoreFields.summary],
      'description': data[FirestoreFields.description],
      'instructor': data[FirestoreFields.instructorName],
      'category': data[FirestoreFields.categoryName],
      'level': data[FirestoreFields.level],
      'lessons': lessonSnapshot.docs
          .map((l) => <String, dynamic>{...l.data(), 'id': l.id})
          .toList(),
    });
  }
}

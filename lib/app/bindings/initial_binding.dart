import 'package:get/get.dart';

import '../../core/services/thumbnail_service.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/course_repository.dart';
import '../../data/repositories/firebase_auth_repository.dart';
import '../../data/repositories/firestore_course_repository.dart';

/// Binding global. Implementasi aktif: Firebase Auth + Firestore.
/// Mock lama (MockAuthRepository, MockCourseRepository) masih bisa dipasang
/// kembali di sini tanpa mengubah ViewModel.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => FirebaseAuthRepository(), fenix: true);
    Get.lazyPut<CourseRepository>(() => FirestoreCourseRepository(), fenix: true);
    Get.lazyPut<ThumbnailService>(() => ThumbnailService(Get.find()), fenix: true);
  }
}

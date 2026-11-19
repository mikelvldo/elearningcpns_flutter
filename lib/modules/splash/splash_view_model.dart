import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../core/services/local_storage_service.dart';
import '../../core/services/secure_storage_service.dart';

class SplashViewModel extends GetxController {
  SplashViewModel(this._secureStorage, this._localStorage);

  final SecureStorageService _secureStorage;
  final LocalStorageService _localStorage;

  @override
  void onReady() {
    super.onReady();
    _bootstrap();
  }

  /// Alur: ada token -> home, belum lihat intro -> intro, selain itu -> login.
  Future<void> _bootstrap() async {
    await Future<void>.delayed(const Duration(milliseconds: 2200));

    final token = await _secureStorage.readToken();
    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(Routes.home);
    } else if (_localStorage.hasSeenIntro) {
      Get.offAllNamed(Routes.login);
    } else {
      Get.offAllNamed(Routes.intro);
    }
  }
}

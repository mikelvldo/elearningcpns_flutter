import 'package:get/get.dart';

import 'splash_view_model.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put (bukan lazyPut) agar ViewModel langsung dibuat dan onReady jalan.
    Get.put<SplashViewModel>(SplashViewModel(Get.find(), Get.find()));
  }
}

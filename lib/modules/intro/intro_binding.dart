import 'package:get/get.dart';

import 'intro_view_model.dart';

class IntroBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroViewModel>(() => IntroViewModel(Get.find()));
  }
}

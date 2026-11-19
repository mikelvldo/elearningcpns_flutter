import 'package:get/get.dart';

import 'player_view_model.dart';

class PlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayerViewModel>(() => PlayerViewModel(Get.find()));
  }
}

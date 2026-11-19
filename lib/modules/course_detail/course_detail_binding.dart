import 'package:get/get.dart';

import 'course_detail_view_model.dart';

class CourseDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourseDetailViewModel>(
      () => CourseDetailViewModel(Get.find(), Get.find()),
    );
  }
}

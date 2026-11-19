import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../../core/widgets/course_thumbnail.dart';
import '../../core/widgets/section_title.dart';
import '../../core/widgets/state_message.dart';
import 'home_view_model.dart';
import 'widgets/continue_card.dart';
import 'widgets/course_card.dart';
import 'widgets/course_card_skeleton.dart';
import 'widgets/home_header.dart';

class HomeView extends GetView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: RefreshIndicator(
          onRefresh: controller.loadCourses,
          child: ListView(
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              HomeHeader(controller: controller),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
                child: Obx(_buildContent),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Dipanggil langsung di dalam Obx agar observable terbaca di scope Obx.
  Widget _buildContent() {
    if (controller.isLoading.value) {
      return Column(
        children: List.generate(3, (_) => const CourseCardSkeleton()),
      );
    }

    final error = controller.errorMessage.value;
    if (error != null) {
      return StateMessage(
        icon: Icons.wifi_off_rounded,
        text: error,
        actionLabel: 'Coba lagi',
        onAction: controller.loadCourses,
      );
    }

    if (controller.courses.isEmpty) {
      return const StateMessage(
        icon: Icons.inbox_outlined,
        text: 'Belum ada course tersedia.',
      );
    }

    final info = controller.continueInfo.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (info != null) ...[
          ContinueCard(
            info: info,
            onTap: () => controller.continueLearning(info),
          ),
          SizedBox(height: 24.h),
        ],
        const SectionTitle('Semua Course'),
        SizedBox(height: 14.h),
        for (final course in controller.courses)
          Padding(
            padding: EdgeInsets.only(bottom: 18.h),
            child: CourseCard(
              course: course,
              onTap: () => controller.openCourse(course),
              thumbnail: Obx(
                () => CourseThumbnail(bytes: controller.thumbnails[course.id]),
              ),
            ),
          ),
      ],
    );
  }
}

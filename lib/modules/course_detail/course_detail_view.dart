import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/course_thumbnail.dart';
import '../../core/widgets/section_title.dart';
import 'course_detail_view_model.dart';
import 'widgets/course_hero_app_bar.dart';
import 'widgets/course_info_section.dart';
import 'widgets/lesson_tile.dart';

class CourseDetailView extends GetView<CourseDetailViewModel> {
  const CourseDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [
            CourseHeroAppBar(
              thumbnail: Obx(
                () => CourseThumbnail(bytes: controller.thumbnail.value),
              ),
            ),
            SliverToBoxAdapter(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    final course = controller.course;
    return Container(
      transform: Matrix4.translationValues(0, -20.h, 0),
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 32.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CourseInfoSection(course: course),
          SizedBox(height: 24.h),
          const SectionTitle('Tentang course'),
          SizedBox(height: 8.h),
          Text(
            course.description,
            style: AppTextStyles.body.copyWith(fontSize: 14.sp, height: 1.6),
          ),
          SizedBox(height: 24.h),
          const SectionTitle('Daftar lesson'),
          SizedBox(height: 12.h),
          ..._buildLessons(),
        ],
      ),
    );
  }

  List<Widget> _buildLessons() {
    final lessons = controller.course.lessons;
    if (lessons.isEmpty) {
      return [
        Text('Belum ada lesson pada course ini.', style: AppTextStyles.body),
      ];
    }
    return [
      for (final lesson in lessons)
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Obx(
            () => LessonTile(
              lesson: lesson,
              isLast: controller.lastLessonId.value == lesson.id,
              onTap: () => controller.openLesson(lesson),
            ),
          ),
        ),
    ];
  }
}

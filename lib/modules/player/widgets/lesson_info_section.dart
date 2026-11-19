import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../player_view_model.dart';

/// Judul, deskripsi, dan tombol Sebelumnya/Berikutnya untuk lesson aktif.
class LessonInfoSection extends StatelessWidget {
  const LessonInfoSection({super.key, required this.controller});

  final PlayerViewModel controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final lesson = controller.lesson;
      final index = controller.currentIndex.value;
      final total = controller.course.lessons.length;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('LESSON ${index + 1} DARI $total', style: AppTextStyles.overline),
          SizedBox(height: 6.h),
          Text(
            lesson.title,
            style: TextStyle(
              fontSize: 20.sp,
              height: 1.3,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(lesson.description,
              style: AppTextStyles.body.copyWith(height: 1.55)),
          SizedBox(height: 16.h),
          _buildNavButtons(),
        ],
      );
    });
  }

  Widget _buildNavButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: controller.hasPrevious ? controller.previous : null,
            icon: const Icon(Icons.skip_previous_rounded),
            label: const Text('Sebelumnya'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              minimumSize: Size.fromHeight(46.h),
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: controller.hasNext ? controller.next : null,
            icon: const Icon(Icons.skip_next_rounded),
            label: const Text('Berikutnya'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(46.h),
              textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}

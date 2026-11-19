import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/utils/format_utils.dart';
import '../../../data/models/lesson.dart';

/// Baris lesson di halaman detail; [isLast] menandai lesson terakhir dibuka.
class LessonTile extends StatelessWidget {
  const LessonTile({
    super.key,
    required this.lesson,
    required this.isLast,
    required this.onTap,
  });

  final Lesson lesson;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isLast ? AppColors.primary : AppColors.border,
          width: isLast ? 1.5 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(14.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNumber(),
                SizedBox(width: 12.w),
                Expanded(child: _buildTexts()),
                SizedBox(width: 8.w),
                Icon(Icons.play_circle_fill_rounded,
                    size: 30.r, color: AppColors.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumber() {
    return Container(
      width: 36.r,
      height: 36.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isLast ? AppColors.primary : AppColors.primaryLight,
        shape: BoxShape.circle,
      ),
      child: Text(
        '${lesson.order}',
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w800,
          color: isLast ? AppColors.white : AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lesson.title,
          style: TextStyle(
            fontSize: 14.sp,
            height: 1.3,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          lesson.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.body.copyWith(fontSize: 12.sp, height: 1.45),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(Icons.schedule_rounded, size: 14.r, color: AppColors.primary),
            SizedBox(width: 4.w),
            Text(
              formatDuration(lesson.durationSeconds),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            if (isLast) ...[
              SizedBox(width: 10.w),
              Text(
                'Terakhir dibuka',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

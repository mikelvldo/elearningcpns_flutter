import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/utils/format_utils.dart';
import '../../../core/widgets/app_badge.dart';
import '../../../data/models/course.dart';
import 'course_stat.dart';

/// Kategori, judul, pengajar, dan baris statistik course.
class CourseInfoSection extends StatelessWidget {
  const CourseInfoSection({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBadge(label: course.category),
        SizedBox(height: 12.h),
        Text(
          course.title,
          style: TextStyle(
            fontSize: 22.sp,
            height: 1.3,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Icon(Icons.account_circle_outlined,
                size: 18.r, color: AppColors.primary),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                course.instructor,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        Row(
          children: [
            CourseStat(
              icon: Icons.play_lesson_outlined,
              value: '${course.lessons.length}',
              label: 'Lesson',
            ),
            SizedBox(width: 10.w),
            CourseStat(
              icon: Icons.schedule_rounded,
              value: formatDuration(course.totalDurationSeconds),
              label: 'Durasi',
            ),
            SizedBox(width: 10.w),
            CourseStat(
              icon: Icons.signal_cellular_alt_rounded,
              value: levelLabel(course.level),
              label: 'Level',
            ),
          ],
        ),
      ],
    );
  }
}

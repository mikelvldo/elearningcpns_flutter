import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/widgets/app_badge.dart';
import '../../../data/models/course.dart';
import 'course_card_media.dart';

/// Kartu course: gambar di atas, info singkat di bawah, bisa diklik.
class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
    required this.thumbnail,
    required this.onTap,
  });

  final Course course;
  final Widget thumbnail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x141E5EFF),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CourseCardMedia(course: course, thumbnail: thumbnail),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
                child: _buildInfo(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          course.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.cardTitle,
        ),
        SizedBox(height: 6.h),
        Text(
          course.summary,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.body.copyWith(height: 1.45),
        ),
        SizedBox(height: 14.h),
        const Divider(height: 1, color: AppColors.border),
        SizedBox(height: 12.h),
        _buildFooter(),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        Icon(Icons.account_circle_outlined,
            size: 18.r, color: AppColors.primary),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            course.instructor,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        AppBadge(label: '${course.lessons.length} lesson'),
        SizedBox(width: 8.w),
        Icon(Icons.arrow_forward_rounded, size: 20.r, color: AppColors.primary),
      ],
    );
  }
}

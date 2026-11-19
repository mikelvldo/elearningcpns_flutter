import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../home_view_model.dart';

/// Kartu "Lanjutkan belajar" menuju lesson terakhir yang dibuka.
class ContinueCard extends StatelessWidget {
  const ContinueCard({super.key, required this.info, required this.onTap});

  final ContinueInfo info;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(14.r),
            child: Row(
              children: [
                _PlayCircle(),
                SizedBox(width: 12.w),
                Expanded(child: _buildTexts()),
                Icon(Icons.chevron_right_rounded,
                    size: 24.r, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LANJUTKAN BELAJAR',
          style: AppTextStyles.overline.copyWith(fontSize: 10.sp),
        ),
        SizedBox(height: 3.h),
        Text(
          info.lesson.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          info.course.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _PlayCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.r,
      height: 44.r,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.play_arrow_rounded, size: 26.r, color: AppColors.white),
    );
  }
}

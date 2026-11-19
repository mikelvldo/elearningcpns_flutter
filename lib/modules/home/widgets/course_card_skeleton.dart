import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/app_colors.dart';

/// Placeholder kartu course saat data sedang dimuat.
class CourseCardSkeleton extends StatelessWidget {
  const CourseCardSkeleton({super.key});

  static const _shade = Color(0xFFE3EAFB);

  Widget _bar(double width, double height) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: _shade,
          borderRadius: BorderRadius.circular(8.r),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18.h),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AspectRatio(
            aspectRatio: 16 / 9,
            child: ColoredBox(color: _shade),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bar(double.infinity, 16.h),
                SizedBox(height: 10.h),
                _bar(220.w, 12.h),
                SizedBox(height: 8.h),
                _bar(120.w, 12.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

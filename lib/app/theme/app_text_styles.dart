import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

/// Gaya teks yang dipakai berulang. Getter (bukan const) karena memakai .sp.
class AppTextStyles {
  static TextStyle get section => TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      );

  static TextStyle get cardTitle => TextStyle(
        fontSize: 16.sp,
        height: 1.3,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      );

  static TextStyle get body => TextStyle(
        fontSize: 13.sp,
        height: 1.5,
        color: AppColors.textSecondary,
      );

  static TextStyle get overline => TextStyle(
        fontSize: 11.sp,
        letterSpacing: 0.8,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      );
}

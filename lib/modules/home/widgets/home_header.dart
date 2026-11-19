import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_logo.dart';
import '../home_view_model.dart';
import 'stat_chip.dart';

/// Header biru: logo, tombol keluar, sapaan, dan ringkasan jumlah course.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.controller});

  final HomeViewModel controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20.w,
        MediaQuery.of(context).padding.top + 12.h,
        12.w,
        28.h,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopBar(),
          SizedBox(height: 22.h),
          _buildGreeting(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        const AppLogo(size: 36, inverted: true),
        SizedBox(width: 10.w),
        Text(
          AppStrings.appName,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.white,
          ),
        ),
        const Spacer(),
        IconButton(
          tooltip: 'Keluar',
          onPressed: controller.logout,
          icon: const Icon(Icons.logout_rounded, color: AppColors.white),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selamat belajar,',
            style: TextStyle(fontSize: 14.sp, color: AppColors.whiteMuted),
          ),
          SizedBox(height: 4.h),
          Text(
            'Siap lolos seleksi CPNS?',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 18.h),
          Obx(() {
            if (controller.isLoading.value || controller.courses.isEmpty) {
              return const SizedBox.shrink();
            }
            return Row(
              children: [
                StatChip(
                  icon: Icons.menu_book_rounded,
                  label: '${controller.courses.length} course',
                ),
                SizedBox(width: 10.w),
                StatChip(
                  icon: Icons.play_circle_outline_rounded,
                  label: '${controller.totalLessons} lesson',
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

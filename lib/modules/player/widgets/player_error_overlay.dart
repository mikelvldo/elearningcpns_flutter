import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/app_colors.dart';

/// Lapisan error di atas video dengan tombol coba lagi / buka di YouTube.
class PlayerErrorOverlay extends StatelessWidget {
  const PlayerErrorOverlay({
    super.key,
    required this.message,
    required this.onRetry,
    this.onOpenExternal,
  });

  final String message;
  final VoidCallback onRetry;

  /// Null = tombol "Buka di YouTube" disembunyikan.
  final VoidCallback? onOpenExternal;

  @override
  Widget build(BuildContext context) {
    final buttonText = TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600);

    return Container(
      color: const Color(0xEB0B1530),
      padding: EdgeInsets.all(16.r),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline_rounded,
                  size: 34.r, color: AppColors.white),
              SizedBox(height: 8.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  height: 1.4,
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 12.h),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  ElevatedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Coba lagi'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(0, 38.h),
                      textStyle: buttonText,
                    ),
                  ),
                  if (onOpenExternal != null)
                    OutlinedButton.icon(
                      onPressed: onOpenExternal,
                      icon: const Icon(Icons.open_in_new_rounded),
                      label: const Text('Buka di YouTube'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.white,
                        minimumSize: Size(0, 38.h),
                        side: const BorderSide(color: AppColors.white),
                        textStyle: buttonText,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

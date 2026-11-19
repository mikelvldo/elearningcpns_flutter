import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/app_colors.dart';

/// Baris lesson pada playlist di bawah video; [isPlaying] = lesson aktif.
class PlaylistTile extends StatelessWidget {
  const PlaylistTile({
    super.key,
    required this.number,
    required this.title,
    required this.duration,
    required this.isPlaying,
    required this.onTap,
  });

  final int number;
  final String title;
  final String duration;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isPlaying ? AppColors.primaryLight : AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isPlaying ? AppColors.primary : AppColors.border,
          width: isPlaying ? 1.5 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Row(
              children: [
                _buildLeading(),
                SizedBox(width: 12.w),
                Expanded(child: _buildTexts()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeading() {
    return Container(
      width: 32.r,
      height: 32.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isPlaying ? AppColors.primary : AppColors.primaryLight,
        shape: BoxShape.circle,
      ),
      child: isPlaying
          ? Icon(Icons.equalizer_rounded, size: 18.r, color: AppColors.white)
          : Text(
              '$number',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
    );
  }

  Widget _buildTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 13.sp,
            height: 1.3,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          isPlaying ? 'Sedang diputar  •  $duration' : duration,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

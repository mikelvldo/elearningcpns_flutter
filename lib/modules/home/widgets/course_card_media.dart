import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/utils/format_utils.dart';
import '../../../core/widgets/app_badge.dart';
import '../../../data/models/course.dart';

/// Bagian gambar kartu course: thumbnail, tombol play, badge kategori & durasi.
class CourseCardMedia extends StatelessWidget {
  const CourseCardMedia({
    super.key,
    required this.course,
    required this.thumbnail,
  });

  final Course course;

  /// Widget gambar (mis. CourseThumbnail) yang mengisi area ini.
  final Widget thumbnail;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          thumbnail,
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x00000000), Color(0x99000000)],
                stops: [0.45, 1],
              ),
            ),
          ),
          Center(child: _PlayButton()),
          Positioned(
            top: 12.h,
            left: 12.w,
            child: AppBadge(
              label: course.category,
              background: AppColors.white,
            ),
          ),
          Positioned(
            right: 12.w,
            bottom: 12.h,
            child: AppBadge(
              icon: Icons.schedule_rounded,
              label: formatDuration(course.totalDurationSeconds),
              background: const Color(0xB3000000),
              foreground: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.r,
      height: 48.r,
      decoration: const BoxDecoration(
        color: Color(0x66000000),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.play_arrow_rounded, size: 30.r, color: AppColors.white),
    );
  }
}

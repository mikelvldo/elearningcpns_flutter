import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/theme/app_colors.dart';

/// Gambar thumbnail memenuhi area induknya. Jika belum ada / gagal dimuat,
/// tampil placeholder biru lembut.
class CourseThumbnail extends StatelessWidget {
  const CourseThumbnail({super.key, this.bytes});

  final Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: bytes == null
          ? const _Placeholder(key: ValueKey('placeholder'))
          : Image.memory(
              bytes!,
              key: const ValueKey('image'),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              gaplessPlayback: true,
              errorBuilder: (_, __, ___) => const _Placeholder(),
            ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryLight, AppColors.border],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.ondemand_video_rounded,
          size: 44.r,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

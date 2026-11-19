import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_colors.dart';
import '../player_view_model.dart';

/// Lapisan di atas video: double tap kiri = mundur 10 detik, kanan = maju.
/// Bagian tengah, atas, dan bawah dibiarkan bebas agar kontrol bawaan player
/// (play/pause, seek bar) tetap bisa disentuh.
class SeekOverlay extends StatelessWidget {
  const SeekOverlay({super.key, required this.controller});

  final PlayerViewModel controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 44.h, bottom: 56.h),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: _SeekZone(side: -1, controller: controller),
          ),
          const Expanded(flex: 4, child: SizedBox.shrink()),
          Expanded(
            flex: 3,
            child: _SeekZone(side: 1, controller: controller),
          ),
        ],
      ),
    );
  }
}

class _SeekZone extends StatelessWidget {
  const _SeekZone({required this.side, required this.controller});

  /// -1 = kiri (mundur), 1 = kanan (maju)
  final int side;
  final PlayerViewModel controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onDoubleTap: () => controller.seekBy(side * 10),
      onTap: controller.togglePlay,
      child: Obx(() {
        final active = controller.seekSide.value == side;
        final total = controller.seekTotal.value;
        return Center(
          child: AnimatedOpacity(
            opacity: active ? 1 : 0,
            duration: const Duration(milliseconds: 150),
            child: _SeekBubble(forward: side > 0, seconds: total),
          ),
        );
      }),
    );
  }
}

class _SeekBubble extends StatelessWidget {
  const _SeekBubble({required this.forward, required this.seconds});

  final bool forward;
  final int seconds;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: const BoxDecoration(
        color: Color(0x99000000),
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            forward ? Icons.fast_forward_rounded : Icons.fast_rewind_rounded,
            size: 26.r,
            color: AppColors.white,
          ),
          Text(
            '$seconds detik',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

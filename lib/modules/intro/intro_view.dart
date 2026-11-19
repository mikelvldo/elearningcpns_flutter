import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/widgets/primary_button.dart';
import 'intro_view_model.dart';
import 'widgets/intro_page.dart';
import 'widgets/page_indicator.dart';

class IntroView extends GetView<IntroViewModel> {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildSkipButton(),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.items.length,
                itemBuilder: (_, index) =>
                    IntroPage(item: controller.items[index]),
              ),
            ),
            Obx(
              () => PageIndicator(
                count: controller.items.length,
                current: controller.currentPage.value,
              ),
            ),
            SizedBox(height: 28.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Obx(
                () => PrimaryButton(
                  label: controller.isLastPage ? 'Mulai Sekarang' : 'Lanjut',
                  onPressed: controller.next,
                ),
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  /// Tombol "Lewati", disembunyikan di halaman terakhir.
  Widget _buildSkipButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w, top: 8.h),
        child: Obx(
          () => AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: controller.isLastPage ? 0 : 1,
            child: TextButton(
              onPressed: controller.isLastPage ? null : controller.finish,
              child: const Text('Lewati'),
            ),
          ),
        ),
      ),
    );
  }
}

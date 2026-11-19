import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../core/services/local_storage_service.dart';
import 'intro_item.dart';

class IntroViewModel extends GetxController {
  IntroViewModel(this._localStorage);

  final LocalStorageService _localStorage;

  final pageController = PageController();
  final currentPage = 0.obs;

  final items = const <IntroItem>[
    IntroItem(
      icon: Icons.play_circle_fill_rounded,
      title: 'Belajar Kapan Saja',
      description:
          'Tonton video materi persiapan CPNS langsung dari ponselmu, tanpa terikat jadwal.',
    ),
    IntroItem(
      icon: Icons.menu_book_rounded,
      title: 'Materi Terstruktur',
      description:
          'Course disusun bertahap, mulai dari SKD, TWK, SKB, hingga psikotes dan wawancara.',
    ),
    IntroItem(
      icon: Icons.history_rounded,
      title: 'Lanjutkan Belajarmu',
      description:
          'Progres terakhir tersimpan, jadi kamu bisa melanjutkan dari video yang terakhir ditonton.',
    ),
  ];

  bool get isLastPage => currentPage.value == items.length - 1;

  void onPageChanged(int index) => currentPage.value = index;

  Future<void> next() async {
    if (isLastPage) {
      await finish();
    } else {
      await pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> finish() async {
    await _localStorage.setIntroSeen();
    Get.offAllNamed(Routes.login);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

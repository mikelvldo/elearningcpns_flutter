import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/theme/app_colors.dart';

/// Logo aplikasi (kotak membulat + ikon sekolah). [size] dalam satuan desain.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, required this.size, this.inverted = false});

  final double size;

  /// false: kotak biru + ikon putih. true: kotak putih + ikon biru.
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        color: inverted ? AppColors.white : AppColors.primary,
        borderRadius: BorderRadius.circular(size.r * 0.27),
      ),
      child: Icon(
        Icons.school_rounded,
        size: size.r * 0.56,
        color: inverted ? AppColors.primary : AppColors.white,
      ),
    );
  }
}

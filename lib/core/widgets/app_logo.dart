import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/theme/app_colors.dart';
import '../constants/asset_paths.dart';

/// Logo aplikasi dari assets/logo/logo.png. [size] dalam satuan desain.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, required this.size, this.inverted = false});

  final double size;

  /// true: dialasi kotak putih (untuk latar biru, mis. splash dan header).
  /// false: tanpa alas (untuk latar putih, mis. login).
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      AssetPaths.logo,
      width: size.r,
      height: size.r,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Icon(
        Icons.school_rounded,
        size: size.r * 0.8,
        color: inverted ? AppColors.white : AppColors.primary,
      ),
    );

    if (!inverted) return image;

    return Container(
      width: size.r,
      height: size.r,
      padding: EdgeInsets.all(size.r * 0.1),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(size.r * 0.27),
      ),
      child: image,
    );
  }
}
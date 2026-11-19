import 'package:flutter/material.dart';

/// Palet warna dominan biru dan putih.
class AppColors {
  static const primary = Color(0xFF1E5EFF);
  static const primaryDark = Color(0xFF0B3BB8);
  static const primaryLight = Color(0xFFE8F0FF);
  static const primaryDisabled = Color(0xFF7BA0FF);

  static const white = Colors.white;
  static const background = Color(0xFFF5F8FF);
  static const border = Color(0xFFD6E0F5);

  static const textPrimary = Color(0xFF0F1B3D);
  static const textSecondary = Color(0xFF6B7794);

  static const error = Color(0xFFD93025);
  static const errorBackground = Color(0xFFFDECEA);

  // Putih transparan (tanpa withOpacity agar aman lintas versi Flutter).
  static const whiteSoft = Color(0x33FFFFFF);
  static const whiteMuted = Color(0xCCFFFFFF);
}

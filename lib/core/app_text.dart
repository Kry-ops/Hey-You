import 'package:flutter/material.dart';
import '../core/app_colors.dart';
// Pengaturan gaya tulisan.
class AppText {
  static const String? mainFont = null;

  static const featureTitle = TextStyle(
    fontFamily: mainFont,
    fontSize: 15,
    color: AppColors.cream,
  );

  static const navLabel = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    letterSpacing: 0,
    color: AppColors.cream,
  );

  
  // Gaya teks petunjuk swipe.
  static const swipeInstruction = TextStyle(
    fontFamily: mainFont,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.1,
    color: AppColors.dark,
  );

}
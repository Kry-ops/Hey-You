// app_text.dart
import 'package:flutter/material.dart';
import '../core/app_colors.dart';
// Pengaturan gaya tulisan.
class AppText {
  // Home Page
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
  

  // MBTI Page
  static const question = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 18,
    height: 1.5,
    color: AppColors.cream,
  );
  static const answer = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 15,
    color: AppColors.cream,
  );
  static const counter = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 16,
    letterSpacing: 1,
    color: AppColors.dark,
  );
  static const nextLabel = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 24,
    letterSpacing: 5,
    color: AppColors.cream,
  );
  static const heading = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 20,
    color: AppColors.cream,
  );
  static const bigCode = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 48,
    letterSpacing: 6,
    fontWeight: FontWeight.bold,
    color: AppColors.cream,
  );

}
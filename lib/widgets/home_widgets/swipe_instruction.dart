
import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/app_text.dart';
import '../../utils/home_layout.dart';
import '../asset_or_icon.dart';

// =====================================================================
// SWIPE INSTRUCTION
// Widget petunjuk swipe yang pengaturannya diambil dari file lain.
// =====================================================================

class SwipeInstruction extends StatelessWidget {
  const SwipeInstruction({
    super.key,
    this.label = 'SWIPE KE KANAN TOMBOLNYA',
    this.assetPath = AppAssets.iconSwipe,
    this.fallbackIcon = Icons.swipe_right_alt_rounded,
    this.rightAssetPath = AppAssets.iconPanahSwipe,
    this.rightFallbackIcon = Icons.arrow_forward_rounded,
  });

  // Pengaturan yang dapat diubah saat widget dipanggil.
  final String label;
  final String assetPath;
  final IconData fallbackIcon;
  final String rightAssetPath;
  final IconData rightFallbackIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Ikon kiri.
        AssetOrIcon(
          assetPath: assetPath,
          fallbackIcon: fallbackIcon,
          size: HomeLayout.swipeIconSize,
          color: AppColors.dark,
        ),

        SizedBox(width: HomeLayout.swipeIconGap),

        // Label petunjuk.
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppText.swipeInstruction,
        ),

        SizedBox(width: HomeLayout.swipeIconGap),

        // Ikon kanan.
        AssetOrIcon(
          assetPath: rightAssetPath,
          fallbackIcon: rightFallbackIcon,
          size: HomeLayout.swipeIconSize,
        ),
      ],
    );
  }
}

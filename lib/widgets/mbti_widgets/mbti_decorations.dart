// mbti_decoration.dart
import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../widgets/asset_or_icon.dart';

import '../../utils/mbti_layout.dart';

// Dekorasi di belakang konten. Tidak menerima sentuhan.
class Decorations extends StatelessWidget {
  const Decorations({required this.width, required this.height});
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          // Tanaman kiri bawah
          Positioned(
            left: -width * 0.04,
            bottom: 0,
            child: AssetOrIcon(
              assetPath: AppAssets.plantLeft,
              fallbackIcon: Icons.eco,
              size: width * MbtiLayout.plantLeftSize,
            ),
          ),
          // Tanaman kanan bawah
          Positioned(
            right: 0,
            bottom: 0,
            child: AssetOrIcon(
              assetPath: AppAssets.plantRight,
              fallbackIcon: Icons.eco,
              size: width * MbtiLayout.plantRightSize,
            ),
          ),
          // Kucing
          Positioned(
            right: width * MbtiLayout.catRight,
            bottom: 0,
            child: AssetOrIcon(
              assetPath: AppAssets.cat,
              fallbackIcon: Icons.pets,
              size: width * MbtiLayout.catSize,
            ),
          ),
          // Kupu-kupu
          Positioned(
            right: width * MbtiLayout.butterflyRight,
            bottom: height * MbtiLayout.butterflyBottom,
            child: AssetOrIcon(
              assetPath: AppAssets.butterfly,
              fallbackIcon: Icons.flutter_dash,
              size: width * MbtiLayout.butterflySize,
            ),
          ),
          // Kilau-kilau
          for (final spot in MbtiLayout.sparkles)
            Positioned(
              right: width * spot.right,
              bottom: height * spot.bottom,
              child: AssetOrIcon(
                assetPath: AppAssets.sparkle,
                fallbackIcon: Icons.auto_awesome,
                size: width * spot.size,
              ),
            ),
        ],
      ),
    );
  }
}

// mbti_progress.dart
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text.dart';
import '../../core/app_assets.dart';
import '../../widgets/asset_or_icon.dart';

import '../../utils/mbti_layout.dart';

// progress di atas card
class ProgressHeader extends StatelessWidget {
  const ProgressHeader({required this.current, required this.total});
  final int current;
  final int total;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$current / $total', style: AppText.counter),
        const SizedBox(height: 6),
        Row(
          children: [
            // Daun kiri
            const AssetOrIcon(
              assetPath: AppAssets.progressLeaf,
              fallbackIcon: Icons.eco,
              size: MbtiLayout.progressLeafSize,
            ),
            const SizedBox(width: 4),
            // Progress bar
            Expanded(child: _ProgressBar(value: current / total)),
            const SizedBox(width: 4),
            // Daun kanan (daun kiri yang dicerminkan)
            Transform.flip(
              flipX: true,
              child: const AssetOrIcon(
                assetPath: AppAssets.progressLeaf,
                fallbackIcon: Icons.eco,
                size: MbtiLayout.progressLeafSize,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value});
  final double value; // 0.0 sampai 1.0*
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const radius = BorderRadius.all(Radius.circular(10));
        return SizedBox(
          height: MbtiLayout.progressHeight,
          child: Stack(
            children: [
              // Latar
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.progressTrack,
                  borderRadius: radius,
                ),
              ),
              // Isi (bertambah dengan animasi)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: constraints.maxWidth * value.clamp(0.0, 1.0),
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  borderRadius: radius,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
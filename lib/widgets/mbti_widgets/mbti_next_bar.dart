// mbti_next_bar.dart
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text.dart';
import '../../core/app_assets.dart';
import '../../widgets/asset_or_icon.dart';
import '../../utils/mbti_layout.dart';

// BAGIAN 7 — TOMBOL NEXT DAN DEKORASI
// Tombol hijau di bawah: panah kiri = soal sebelumnya,
// teks tengah dan panah kanan = lanjut.
class NextBar extends StatelessWidget {
  const NextBar({
    required this.label,
    required this.enabled,
    required this.onNext,
    required this.onPrev, // null = panah kiri nonaktif*
  });
  final String label;
  final bool enabled;
  final VoidCallback onNext;
  final VoidCallback? onPrev;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: MbtiLayout.nextBarHeight,
      decoration: BoxDecoration(
        color: enabled ? AppColors.green : AppColors.nextDisabled,
        borderRadius: BorderRadius.circular(MbtiLayout.nextBarHeight / 2),
      ),
      child: Row(
        children: [
          _BarArrow(
            assetPath: AppAssets.arrowPrev,
            fallbackIcon: Icons.arrow_left,
            onTap: onPrev,
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onNext,
              child: Center(
                child: Text(label, style: AppText.nextLabel),
              ),
            ),
          ),
          _BarArrow(
            assetPath: AppAssets.arrowNext,
            fallbackIcon: Icons.arrow_right,
            onTap: onNext,
          ),
        ],
      ),
    );
  }
}

class _BarArrow extends StatelessWidget {
  const _BarArrow({
    required this.assetPath,
    required this.fallbackIcon,
    required this.onTap,
  });
  final String assetPath;
  final IconData fallbackIcon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 64,
        height: double.infinity,
        child: Center(
          child: Opacity(
            opacity: onTap == null ? 0.35 : 1,
            child: AssetOrIcon(
              assetPath: assetPath,
              fallbackIcon: fallbackIcon,
              size: 40,
              color: AppColors.cream,
            ),
          ),
        ),
      ),
    );
  }
}

// Tombol pil sederhana (dipakai di halaman hasil).

class PillButton extends StatelessWidget {
  const PillButton({
    required this.label,
    required this.color,
    required this.onTap,
  });
  final String label;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(label, style: AppText.heading),
      ),
    );
  }
}
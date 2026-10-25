import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_assets.dart';
import '../utils/home_layout.dart';
import '../widgets/asset_or_icon.dart';
// BAGIAN 5 — BAGIAN ATAS
// Gambar, logo, dan dropdown menu.
class VideoHeader extends StatelessWidget {
  const VideoHeader({
    super.key,
    this.onMenuSelected,
  });

  // Callback ketika pengguna memilih menu dropdown.
  final ValueChanged<String>? onMenuSelected;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: HomeLayout.headerAspectRatio,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(
            HomeLayout.headerRadius,
          ),
          border: Border.all(
            color: AppColors.videoFrame,
            width: HomeLayout.headerBorder,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                HomeLayout.headerRadius - HomeLayout.headerBorder,
              ),
              child: Image.asset(
                AppAssets.headerImage,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 56,
                      color: Colors.white54,
                    ),
                  );
                },
              ),
            ),

            // Logo di pojok kiri atas
            Positioned(
              top: 8,
              left: 8,
              child: _OverlayButton(
                child: AssetOrIcon(
                  assetPath: AppAssets.logo,
                  fallbackIcon: Icons.pets,
                  size: 25,
                ),
              ),
            ),

            // DROPDOWN MENU KANAN ATAS
            Positioned(
              top: 8,
              right: 8,
              child: PopupMenuButton<String>(
                tooltip: 'Pengaturan aplikasi',
                  color: const Color(0xFFFCF1D0),
                    surfaceTintColor: Colors.transparent,
                // Kirim pilihan ke HomePage.
                onSelected: (value) {
                  onMenuSelected?.call(value);
                },
                // Isi dropdown menu.
                itemBuilder: (context) => [
                  // Menu Settings.
                  PopupMenuItem<String>(
                    value: 'settings',
                    child: Row(
                      children: [
                        AssetOrIcon(
                          assetPath: AppAssets.iconSettings,
                          fallbackIcon: Icons.settings_outlined,
                          size: 22,
                          color: AppColors.dark,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Settings',
                          style: TextStyle(
                            color: AppColors.dark,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Menu Theme.
                  PopupMenuItem<String>(
                    value: 'theme',
                    child: Row(
                      children: [
                        AssetOrIcon(
                          assetPath: AppAssets.iconTheme,
                          fallbackIcon: Icons.palette_outlined,
                          size: 22,
                          color: AppColors.dark,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Dark heme',
                          style: TextStyle(
                            color: AppColors.dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Tampilan tombol dropdown.
                child: Container(
                  width: HomeLayout.overlayButtonSize,
                  height: HomeLayout.overlayButtonSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.overlay,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.sort,
                    color: AppColors.dark,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Tombol kecil dengan latar untuk logo.
class _OverlayButton extends StatelessWidget {
  const _OverlayButton({
    required this.child,
    this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: HomeLayout.overlayButtonSize,
        height: HomeLayout.overlayButtonSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.overlay,
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      ),
    );
  }
}
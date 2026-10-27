import 'package:flutter/material.dart';
import '../../utils/home_layout.dart';
import '../../core/app_colors.dart';
import '../asset_or_icon.dart';
import '../../core/app_text.dart';
// BAGIAN 7 — NAVBAR BAWAH
// Indikator abu-abu bergerak mengikuti menu yang dipilih.

// Data untuk satu item navbar.
class NavItemData {
  const NavItemData({
    required this.label,
    required this.assetPath,
    required this.fallbackIcon,
  });

  final String label;
  final String assetPath;
  final IconData fallbackIcon;
}

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  // Tinggi navbar dari pengaturan utama.
  static const double height = HomeLayout.navbarHeight;

  // Radius sudut navbar.
  static const double _bigRadius = 125;
  static const double _smallRadius = 2;

  final List<NavItemData> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_bigRadius),
          bottomRight: Radius.circular(_bigRadius),
          topRight: Radius.circular(_smallRadius),
          bottomLeft: Radius.circular(_smallRadius),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Setiap item mendapat lebar yang sama.
          final itemWidth = constraints.maxWidth / items.length;

          final indicatorWidth =
              itemWidth * HomeLayout.navIndicatorWidth;

          return Stack(
            children: [
              // Pointer abu-abu di belakang menu aktif.
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                left: currentIndex * itemWidth +
                    (itemWidth - indicatorWidth) / 2,
                top: 0,
                bottom: 0,
                width: indicatorWidth,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.navIndicator,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        HomeLayout.navIndicatorRadius,
                      ),
                      bottomRight: Radius.circular(
                        HomeLayout.navIndicatorRightRadius,
                      ),
                    ),
                  ),
                ),
              ),

              // Ikon dan label setiap menu.
              Row(
                children: [
                  for (int i = 0; i < items.length; i++)
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,

                        // Jalankan navigasi yang diberikan HomePage.
                        onTap: () => onTap(i),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AssetOrIcon(
                              assetPath: items[i].assetPath,
                              fallbackIcon: items[i].fallbackIcon,
                              size: HomeLayout.navIconSize,
                              color: AppColors.cream,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              items[i].label,
                              style: AppText.navLabel,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
 
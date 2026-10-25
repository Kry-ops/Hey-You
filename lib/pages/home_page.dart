
import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_assets.dart';
import '../utils/home_layout.dart';
import '../widgets/video_header.dart';
import '../widgets/swipe_feature_button.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/asset_or_icon.dart';

// BAGIAN 2 — HALAMAN HOME

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Indeks menu navbar yang sedang aktif.
  int _navIndex = 0;

  // Daftar menu navbar.
  static const List<NavItemData> _navItems = [
    NavItemData(
      label: 'HOME',
      assetPath: AppAssets.navHome,
      fallbackIcon: Icons.home_rounded,
    ),
    NavItemData(
      label: 'PETS',
      assetPath: AppAssets.navPets,
      fallbackIcon: Icons.pets,
    ),
    NavItemData(
      label: 'PROFILE',
      assetPath: AppAssets.navProfile,
      fallbackIcon: Icons.account_circle_outlined,
    ),
  ];

  // Membuka halaman tujuan.
  void _openPage(Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  // Menangani pilihan dropdown untuk pengaturan aplikasi.
  // Menu ini tidak diarahkan ke fitur utama aplikasi.
  void _handleMenuSelection(String value) {
    switch (value) {
      case 'settings':
        _openPage(const _PlaceholderPage('Settings'));
        break;

      case 'theme':
        _openPage(const _PlaceholderPage('Change Theme'));
        break;
    }
  }

  // Menangani navigasi navbar bawah.
  void _handleNavTap(int index) {
    // Perbarui indikator navbar.
    setState(() {
      _navIndex = index;
    });

    // Home adalah halaman yang sedang dibuka.
    if (index == 0) {
      return;
    }

    // Buka halaman dummy berdasarkan menu yang dipilih.
    switch (index) {
      case 1:
        _openPage(const _PlaceholderPage('Pets'));
        break;

      case 2:
        _openPage(const _PlaceholderPage('Profile'));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // SafeArea menjaga konten agar tidak tertutup status bar.
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;

            // Lebar konten mengikuti ukuran layar.
            final contentWidth =
                screenWidth * HomeLayout.contentWidth;

            // Margin kiri dan kanan navbar.
            final navSideSpace =
                screenWidth * (1 - HomeLayout.navbarWidth) / 7;

            return SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Stack(
                children: [
                  // 1. SI KUCINGGGGGG
                  Positioned(
                    right: -screenWidth * 0.17,
                    bottom: HomeLayout.navbarHeight + 3,
                    child: IgnorePointer(
                      child: AssetOrIcon(
                        assetPath: AppAssets.cat,
                        fallbackIcon: Icons.pets,
                        size: screenWidth * HomeLayout.catSize,
                      ),
                    ),
                  ),

                  // 2. KONTEN UTAMA
                  SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      HomeLayout.topSpace,
                      0,
                      HomeLayout.navbarHeight + 30,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: contentWidth,
                        child: Column(
                          children: [
                            // HEADER GAMBAR.
                            VideoHeader(
                              onMenuSelected: _handleMenuSelection,
                            ),

                            // Jarak header ke tombol pertama.
                            SizedBox(
                              height: HomeLayout.headerToButton,
                            ),

                            // FITUR 1 — TEST MBTI
                            SwipeFeatureButton(
                              label: 'Test MBTI',
                              assetPath: AppAssets.iconMbti,
                              fallbackIcon: Icons.checklist_rounded,
                              color: AppColors.green,
                              onCompleted: () {
                                _openPage(
                                  const _PlaceholderPage('Test MBTI'),
                                );
                              },
                            ),

                            SizedBox(height: HomeLayout.buttonGap),
                            // FITUR 2 — CHOSE ONE
                            SwipeFeatureButton(
                              label: 'Chose One',
                              assetPath: AppAssets.iconPickOne,
                              fallbackIcon: Icons.touch_app_rounded,
                              color: AppColors.orange,
                              onCompleted: () {
                                _openPage(
                                  const _PlaceholderPage('Chose One'),
                                );
                              },
                            ),

                            SizedBox(height: HomeLayout.buttonGap),
                            // FITUR 3 — PUZZLE GAME
                            SwipeFeatureButton(
                              label: 'Puzzle Game',
                              assetPath: AppAssets.iconPuzzle,
                              fallbackIcon: Icons.extension_rounded,
                              color: AppColors.blue,
                              onCompleted: () {
                                _openPage(
                                  const _PlaceholderPage('Puzzle Game'),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 3. NAVBAR BAWAH
                  Positioned(
                    left: navSideSpace,
                    right: navSideSpace,
                    bottom: HomeLayout.bottomSpace,
                    child: CustomBottomNav(
                      items: _navItems,
                      currentIndex: _navIndex,
                      onTap: _handleNavTap,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
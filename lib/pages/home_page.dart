// home_page.dart
import 'package:flutter/material.dart';

import 'test_mbti_page.dart';
import '../core/app_colors.dart';
import '../core/app_assets.dart';
import '../utils/home_layout.dart';
import '../widgets/home_widgets/video_header.dart';
import '../widgets/home_widgets/swipe_feature_button.dart';
import '../widgets/home_widgets/custom_bottom_nav.dart';
import '../widgets/asset_or_icon.dart';
import '../widgets/home_widgets/swipe_instruction.dart';
import '../pages/sementara.dart';

import '../service/audio_manager.dart';
import '../widgets/music_widgets/music_popup.dart';


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

  // untuk musik  
  @override
  void initState() {
    super.initState();

    // Mulai backsound saat Home pertama kali dibuka.
    AudioManager.instance.startIfNeeded();
  }
  // Membuka halaman tujuan.
  void _openPage(Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  // Menangani pilihan dropdown untuk pengaturan aplikasi.
  void _handleMenuSelection(String value) {
    switch (value) {
      case 'settings':
        _openPage(const PlaceholderPage('Settings'));
        break;
      case 'theme':
        _openPage(const PlaceholderPage('Change Theme'));
        break;
      case 'music':
        showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (_) => const MusicPopup(),
          );
        break;
    }
  }

  // Menangani navigasi navbar bawah.
  void _handleNavTap(int index) {
    setState(() {
      _navIndex = index;
    });

    // Home adalah halaman yang sedang dibuka.
    if (index == 0) return;

    // Buka halaman dummy berdasarkan menu yang dipilih.
    switch (index) {
      case 1:
        _openPage(const PlaceholderPage('Pets'));
        break;
      case 2:
        _openPage(const PlaceholderPage('Profile'));
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
            final contentWidth = screenWidth * HomeLayout.contentWidth;

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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // HEADER CAROUSEL GAMBAR.
                            VideoHeader(
                              onMenuSelected: _handleMenuSelection,
                            ),
                            // PETUNJUK SWIPE.
                            SizedBox(
                              height: HomeLayout.swipeInstructionSpacing,
                            ),

                            const SwipeInstruction(
                              label: 'SWIPE KE KANAN TOMBOLNYA',
                              assetPath: AppAssets.iconSwipe,
                              fallbackIcon: Icons.swipe_right_alt_rounded,
                              rightAssetPath: AppAssets.iconPanahSwipe,
                              rightFallbackIcon: Icons.arrow_forward_rounded,
                            ),

                            SizedBox(
                              height: HomeLayout.swipeInstructionSpacing,
                            ),


                            // FITUR 1 — TEST MBTI
                            SwipeFeatureButton(
                              label: 'Test MBTI',
                              assetPath: AppAssets.iconMbti,
                              fallbackIcon: Icons.checklist_rounded,
                              color: AppColors.green,
                              onCompleted: () {
                                _openPage(const TestMbtiPage());
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
                                _openPage(const PlaceholderPage('Chose One'));
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
                                _openPage(const PlaceholderPage('Puzzle Game'));
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
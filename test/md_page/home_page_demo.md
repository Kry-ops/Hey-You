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
  void _handleMenuSelection(String value) {
    switch (value) {
      case 'settings':
        _openPage(const PlaceholderPage('Settings'));
        break;
      case 'theme':
        _openPage(const PlaceholderPage('Change Theme'));
        break;
      case 'music':
        _openPage(const PlaceholderPage('Music Control'));
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

// home_layout.dart
class HomeLayout {
  // LEBAR KOMPONEN
  static const double contentWidth = 0.90;
  static const double navbarWidth = 0.92;
  static const double catSize = 0.90;

  // JARAK VERTIKAL
  static const double topSpace = 24;
  static const double headerToButton = 40;
  static const double buttonGap = 20;
  static const double bottomSpace = 12;

  // UKURAN KOMPONEN
  static const double headerAspectRatio = 536 / 284;
  static const double buttonHeight = 62;
  static const double navbarHeight = 60;

  // BENTUK KOMPONEN
  static const double headerRadius = 22;
  static const double headerBorder = 5;

  // UKURAN IKON
  static const double featureIconSize = 32;
  static const double navIconSize = 22;
  static const double overlayButtonSize = 30;

  // POINTER NAVBAR
  static const double navIndicatorWidth = 0.68;
  static const double navIndicatorRadius = 60;
  static const double navIndicatorRightRadius = 60;
  
  // Tombool Geser
  static const double trailLabelCenter = 0.33;

  // PETUNJUK SWIPE
  // Ukuran kedua ikon.
  static const double swipeIconSize = 16;
  static const double swipeIconGap = 7;
  static const double swipeInstructionSpacing = 18;
}

// custom_bottom_nav.dart
import 'package:flutter/material.dart';
import '../../utils/home_layout.dart';
import '../../core/app_colors.dart';
import '../asset_or_icon.dart';
import '../../core/app_text.dart';

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

// swipe_feature_button.dart
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text.dart';
import '../../utils/home_layout.dart';
import '../asset_or_icon.dart';
// TOMBOL FITUR SWIPE
// Geser bulatan ke kanan untuk membuka halaman
class SwipeFeatureButton extends StatefulWidget {
  const SwipeFeatureButton({
    super.key,
    required this.label,
    required this.assetPath,
    required this.fallbackIcon,
    required this.color,
    this.border,
    required this.onCompleted,
  });

  final String label;
  final String assetPath;
  final IconData fallbackIcon;
  final Color color;
  final Border? border;
  final VoidCallback onCompleted;

  @override
  State<SwipeFeatureButton> createState() =>
      _SwipeFeatureButtonState();
}

class _SwipeFeatureButtonState extends State<SwipeFeatureButton> {
  // Ukuran tombol diambil dari pengaturan utama.
  static const double _height = HomeLayout.buttonHeight;
  // Jarak bulatan dan jejak warna dari tepi bingkai cokelat.
  static const double _padding = 10;
  // Persentase geseran minimum agar dianggap berhasil.
  static const double _threshold = 0.70;
  // Durasi animasi ketika tombol kembali ke posisi awal.
  static const Duration _resetDuration = Duration(milliseconds: 250);
  // Durasi animasi sebelum halaman tujuan dibuka.
  static const Duration _openingDuration = Duration(milliseconds: 250);
  // Posisi horizontal bulatan yang sedang digeser.
  double _dx = 0;
  // Menandakan apakah pengguna sedang menggeser bulatan.
  bool _dragging = false;
  // Mencegah pengguna memicu navigasi berulang kali.
  bool _opening = false;
  // Mengatur animasi ketika pengguna melepas bulatan.
  Future<void> _onDragEnd(double maxDx) async {
    // Mencegah pemicu ganda ketika proses navigasi berlangsung.
    if (_opening) return;
    // Periksa apakah geseran sudah mencapai batas minimum.
    if (_dx >= maxDx * _threshold) {
      // Geseran berhasil: bulatan meluncur ke ujung kanan.
      setState(() {
        _dragging = false;
        _opening = true;
        _dx = maxDx;
      });
 
      // Beri waktu agar animasi geseran terlihat.
      await Future.delayed(_openingDuration);
      // Hentikan proses jika widget sudah tidak digunakan.
      if (!mounted) return;
      // Jalankan navigasi menuju halaman yang ditentukan HomePage.
      widget.onCompleted();
      // Tunggu sebentar sebelum mengatur ulang posisi tombol.
      await Future.delayed(const Duration(milliseconds: 400));
      // Pastikan widget masih aktif sebelum memperbarui tampilannya.
      if (!mounted) return;
      // Kembalikan tombol ke posisi awal.
      setState(() {
        _dx = 0;
        _opening = false;
      });
    } else {
      // Geseran tidak mencapai batas: kembalikan tombol ke awal.
      setState(() {
        _dragging = false;
        _dx = 0;
      });
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final buttonWidth = constraints.maxWidth;
        // Lebar bulatan menyesuaikan lebar tombol.
        final knobWidth = buttonWidth * 0.28;
        // Hitung jarak maksimal bulatan hingga ujung kanan.
        final maxDx = (
          buttonWidth - _padding * 2 - knobWidth
        ).clamp(0.0, double.infinity).toDouble();
        // Lebar jejak warna = dari tepi kiri sampai ujung kanan bulatan.
        final trailWidth = _dx + knobWidth;
        // Bentuk pil bagian dalam (jejak warna dan bulatan).
        final innerRadius = BorderRadius.circular(
          (_height - _padding * 2) / 2,
        );
 
        // Lebar area teks pada jejak. Area ini dimulai dari tepi kiri
        // tombol, sehingga titik tengahnya = buttonWidth * trailLabelCenter.
        final trailLabelAreaWidth =
            buttonWidth * HomeLayout.trailLabelCenter * 2;
        // Saat digeser, animasi dimatikan agar mengikuti jari.
        final animDuration = _dragging ? Duration.zero : _resetDuration;
        return Container(
          height: _height,
 
          // Bingkai cokelat tua. Bagian ini tetap terlihat di sekeliling
          // jejak warna.
          decoration: BoxDecoration(
            color: AppColors.dark,
            borderRadius: BorderRadius.circular(_height / 2),
            border: widget.border, // Border dari pemanggilan widget.
          ),
 
          child: Stack(
            children: [
              // 1. TEKS ASLI
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: knobWidth + _padding,
                  ),
                  child: Text(
                    widget.label,
                    style: AppText.featureTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              // 2. MELEBAR MENGIKUTI PERGESERAN TOMBOL DAN MUNCUL TEKS KEDUA
              AnimatedPositioned(
                duration: animDuration,
                curve: Curves.easeOut,
                left: _padding,
                top: _padding,
                bottom: _padding,
                width: trailWidth,
                child: Container(
                  // Potong teks agar tidak keluar dari jejak warna.
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: innerRadius,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: -_padding,
                        top: 0,
                        bottom: 0,
                        width: trailLabelAreaWidth,
                        child: Center(
                          child: Text(
                            widget.label,
                            style: AppText.featureTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 3. BULATAN YANG DAPAT DIGESER
              // Warnanya sama dengan jejak, sehingga menyatu.
              // Berada di paling atas dan menutupi teks di bawahnya.
              AnimatedPositioned(
                duration: animDuration,
                curve: Curves.easeOut,
                left: _padding + _dx,
                top: _padding,
                bottom: _padding,
                width: knobWidth,
                child: GestureDetector(
                  // Mulai proses geseran.
                  onHorizontalDragStart: _opening
                      ? null
                      : (_) {
                          setState(() {
                            _dragging = true;
                          });
                        },
 
                  // Perbarui posisi bulatan dan jejak warna.
                  onHorizontalDragUpdate: _opening
                      ? null
                      : (details) {
                          setState(() {
                            _dx = (
                              _dx + details.delta.dx
                            ).clamp(0.0, maxDx).toDouble();
                          });
                        },
 
                  // Periksa apakah geseran berhasil saat dilepas.
                  onHorizontalDragEnd: _opening
                      ? null
                      : (_) => _onDragEnd(maxDx),
 
                  child: Container(
                    alignment: Alignment.center,
 
                    // Warna bulatan mengikuti warna fitur.
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: innerRadius,
                    ),
 
                    // Ikon fitur tetap menggunakan asset yang tersedia.
                    child: AssetOrIcon(
                      assetPath: widget.assetPath,
                      fallbackIcon: widget.fallbackIcon,
                      size: HomeLayout.featureIconSize,
                      color: AppColors.cream,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// swipe_instruction.dart
import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/app_text.dart';
import '../../utils/home_layout.dart';
import '../asset_or_icon.dart';

// SWIPE INSTRUCTION
// Widget petunjuk swipe yang pengaturannya diambil dari file lain.
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

// video_header.dart
import 'dart:async';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_assets.dart';
import '../../utils/home_layout.dart';
import '../asset_or_icon.dart';

// HEADER CAROUSEL
// Gambar berganti otomatis dan dapat di-swipe secara manual.
class VideoHeader extends StatefulWidget {
  const VideoHeader({
    super.key,
    this.onMenuSelected,
  });

  // Callback ketika pengguna memilih dropdown.
  final ValueChanged<String>? onMenuSelected;
  @override
  State<VideoHeader> createState() => _VideoHeaderState();
}

class _VideoHeaderState extends State<VideoHeader> {
  // Controller untuk mengatur perpindahan gambar.
  final PageController _pageController = PageController();
  // Timer pergantian gambar otomatis.
  Timer? _autoPlayTimer;
  // Indeks halaman yang sedang ditampilkan.
  int _currentPage = 0;
  // Jeda sebelum gambar berikutnya muncul.
  static const Duration _autoPlayInterval =
      Duration(seconds: 5);
  // Durasi animasi perpindahan gambar.
  static const Duration _animationDuration =
      Duration(milliseconds: 600);

  @override
  void initState() {
    super.initState();

    // Mulai pergantian gambar otomatis.
    _startAutoPlay();
  }

  // Memulai atau mengatur ulang timer.
  void _startAutoPlay() {
    _autoPlayTimer?.cancel();

    // Tidak perlu autoplay jika gambar kurang dari dua.
    if (AppAssets.headerImages.length < 2) return;

    _autoPlayTimer = Timer.periodic(
      _autoPlayInterval,
      (_) {
        if (!mounted || !_pageController.hasClients) return;

        // Lanjut ke halaman berikutnya.
        _pageController.animateToPage(
          _currentPage + 1,
          duration: _animationDuration,
          curve: Curves.easeInOut,
        );
      },
    );
  }

  // Memperbarui indeks setelah gambar berubah.
  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });

    // Setelah swipe manual maupun otomatis,
    // hitung kembali jeda autoplay dari awal.
    _startAutoPlay();
  }

  @override
  void dispose() {
    // Hentikan timer saat widget ditutup.
    _autoPlayTimer?.cancel();

    // Lepaskan controller.
    _pageController.dispose();

    super.dispose();
  }

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
            // 1. CAROUSEL GAMBAR
            ClipRRect(
              borderRadius: BorderRadius.circular(
                HomeLayout.headerRadius -
                    HomeLayout.headerBorder,
              ),
              child: PageView.builder(
                controller: _pageController,
                // Tanpa batas halaman agar bisa berulang terus.
                itemCount: null,
                // Dipanggil saat halaman berubah.
                onPageChanged: _onPageChanged,

                itemBuilder: (context, index) {
                  // Ulangi daftar gambar setelah gambar terakhir.
                  final imageIndex =
                      index % AppAssets.headerImages.length;

                  return Image.asset(
                    AppAssets.headerImages[imageIndex],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                    errorBuilder: (_, __, ___) {
                      return const Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 56,
                          color: Colors.white54,
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // 2. LOGO KIRI ATAS
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

            // 3. DROPDOWN KANAN ATAS
            Positioned(
              top: 8,
              right: 8,
              child: PopupMenuButton<String>(
                tooltip: 'Pengaturan aplikasi',
                color: const Color(0xFFFCF1D0),
                surfaceTintColor: Colors.transparent,
                // Kirim pilihan ke HomePage.
                onSelected: (value) {
                  widget.onMenuSelected?.call(value);
                },

                itemBuilder: (context) => [
                  // Menu Settings.
                  PopupMenuItem<String>(
                    value: 'settings',
                    child: Row(
                      children: [
                        AssetOrIcon(
                          assetPath: AppAssets.iconSettings,
                          fallbackIcon: Icons.settings_outlined,
                          size: 20,
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
                          size: 20,
                          color: AppColors.dark,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Dark theme',
                          style: TextStyle(
                            color: AppColors.dark,
                          ),
                        ),
                      ],
                    ),
                  ),

                  PopupMenuItem<String>(
                    value: 'music',
                    child: Row(
                      children: [
                        AssetOrIcon(
                          assetPath: AppAssets.iconMusic,
                          fallbackIcon: Icons.library_music_rounded,
                          size: 20,
                          color: AppColors.dark,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Backsound Music',
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

// TOMBOL OVERLAY UNTUK LOGO
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

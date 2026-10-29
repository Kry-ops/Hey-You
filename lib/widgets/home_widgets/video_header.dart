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

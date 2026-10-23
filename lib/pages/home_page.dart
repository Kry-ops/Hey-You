import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// =====================================================================
// BAGIAN 1 — PENGATURAN (edit warna, asset, dan font di sini saja)
// =====================================================================

/// Warna aplikasi
class AppColors {
  static const background = Color(0xFFFBEFD0); // latar krem
  static const dark = Color(0xFF4B4240); // tombol & navbar (cokelat tua)
  static const cream = Color(0xFFFBEFD0); // warna teks & ikon
  static const green = Color(0xFF7A9A7E); // tombol Test MBTI
  static const orange = Color(0xFFD58A63); // tombol Chose One
  static const blue = Color(0xFF8399B0); // tombol Puzzle Game
  static const navIndicator = Color(0xFF8C8681); // pointer abu-abu navbar
  static const videoFrame = Color(0xFF8C8681); // bingkai video
  static const overlay = Color(0xD9FBEFD0); // kotak logo & menu di atas video
}

/// Lokasi file asset.
/// Kalau file belum ada, aplikasi otomatis menampilkan ikon sementara.
class AppAssets {
  // Header
  static const video = 'assets/videos/amo.mp4';
  static const logo = 'assets/home_page_assets/logo_HY_mini.svg';

  // Ikon tombol fitur
  static const iconMbti = 'assets/home_page_assets/icon_testMBTI.svg';
  static const iconPickOne = 'assets/home_page_assets/icon_pickone.svg';
  static const iconPuzzle = 'assets/home_page_assets/icon_puzzle.svg';

  // Ikon navbar
  static const navHome = 'assets/home_page_assets/icon_home.svg';
  static const navPets = 'assets/home_page_assets/icon_pet.svg';
  static const navProfile = 'assets/home_page_assets/icon_profile.svg';

  // Kucing yang mengintip
  static const cat = 'assets/home_page_assets/kucing.png';
}

/// Font & gaya teks
class AppText {
  /// Isi dengan nama font dari pubspec.yaml, contoh: 'Gilda'.
  /// null = memakai font bawaan Flutter.
  static const String? mainFont = null;

  static const featureTitle = TextStyle(
    fontFamily: mainFont,
    fontSize: 30,
    color: AppColors.cream,
  );

  static const navLabel = TextStyle(
    fontFamily: 'monospace',
    fontSize: 13,
    letterSpacing: 1,
    color: AppColors.cream,
  );
}

// =====================================================================
// BAGIAN 2 — HALAMAN HOME (susunan halaman, daftar fitur & menu navbar)
// =====================================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navIndex = 0; // menu navbar yang sedang aktif

  // Daftar menu navbar -> tambah / ubah di sini
  static const _navItems = [
    NavItemData(label: 'HOME', assetPath: AppAssets.navHome, fallbackIcon: Icons.home_rounded),
    NavItemData(label: 'PETS', assetPath: AppAssets.navPets, fallbackIcon: Icons.pets),
    NavItemData(label: 'PROFILE', assetPath: AppAssets.navProfile, fallbackIcon: Icons.account_circle_outlined),
  ];

  void _openPage(Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // 1. Kucing mengintip (paling belakang)
            //    Atur posisi lewat right / bottom, ukuran lewat size.
            Positioned(
              right: -screenWidth * 0.08,
              bottom: CustomBottomNav.height + 5,
              child: IgnorePointer(
                child: AssetOrIcon(
                  assetPath: AppAssets.cat,
                  fallbackIcon: Icons.pets,
                  size: screenWidth * 0.55,
                  // Tanpa `color`, warna asli gambar kucing dipakai
                ),
              ),
            ),

            // 2. Konten utama: video + tombol fitur
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                20, 16, 20, CustomBottomNav.height + 40,
              ),
              child: Column(
                children: [
                  VideoHeader(onMenuTap: () {
                    // TODO: buka menu / drawer
                  }),
                  const SizedBox(height: 40),

                  // Daftar fitur -> tambah / ubah di sini.
                  // Ganti `_PlaceholderPage(...)` dengan halaman aslimu.
                  SwipeFeatureButton(
                    label: 'Test MBTI',
                    assetPath: AppAssets.iconMbti,
                    fallbackIcon: Icons.checklist_rounded,
                    color: AppColors.green,
                    onCompleted: () => _openPage(const _PlaceholderPage('Test MBTI')),
                  ),
                  const SizedBox(height: 20),
                  SwipeFeatureButton(
                    label: 'Chose One',
                    assetPath: AppAssets.iconPickOne,
                    fallbackIcon: Icons.touch_app_rounded,
                    color: AppColors.orange,
                    onCompleted: () => _openPage(const _PlaceholderPage('Chose One')),
                  ),
                  const SizedBox(height: 20),
                  SwipeFeatureButton(
                    label: 'Puzzle Game',
                    assetPath: AppAssets.iconPuzzle,
                    fallbackIcon: Icons.extension_rounded,
                    color: AppColors.blue,
                    onCompleted: () => _openPage(const _PlaceholderPage('Puzzle Game')),
                  ),
                ],
              ),
            ),

            // 3. Navbar bawah
            Positioned(
              left: 16,
              right: 16,
              bottom: 12,
              child: CustomBottomNav(
                items: _navItems,
                currentIndex: _navIndex,
                onTap: (index) {
                  setState(() => _navIndex = index);
                  // TODO: pindah ke halaman Pets / Profile
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Halaman sementara. HAPUS setelah halaman fitur aslimu siap.
class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(title), backgroundColor: AppColors.background),
      body: Center(child: Text('Halaman $title')),
    );
  }
}

// =====================================================================
// BAGIAN 3 — KOMPONEN (biasanya tidak perlu diubah)
// =====================================================================

/// Menampilkan gambar dari assets.
/// Kalau file gambarnya belum ada, otomatis tampil ikon sementara.
class AssetOrIcon extends StatelessWidget {
  const AssetOrIcon({
    super.key,
    required this.assetPath,
    required this.fallbackIcon,
    this.size = 24,
    this.color, // isi untuk mewarnai ikon; kosongkan agar warna asli dipakai
  });

  final String assetPath;
  final IconData fallbackIcon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: size,
      height: size,
      color: color,
      errorBuilder: (_, __, ___) => Icon(fallbackIcon, size: size, color: color),
    );
  }
}

// ---------------------------------------------------------------------
// Bingkai video di atas, lengkap dengan logo & tombol menu
// ---------------------------------------------------------------------
class VideoHeader extends StatefulWidget {
  const VideoHeader({super.key, this.onMenuTap});

  final VoidCallback? onMenuTap;

  @override
  State<VideoHeader> createState() => _VideoHeaderState();
}

class _VideoHeaderState extends State<VideoHeader> {
  late final VideoPlayerController _controller;
  bool _ready = false;

  @override
  void initState() {
    super.initState();

    // Video dari assets. Untuk video dari internet, ganti dengan:
    // VideoPlayerController.networkUrl(Uri.parse('https://.../video.mp4'))
    _controller = VideoPlayerController.asset(AppAssets.video)
      ..setLooping(true)
      ..setVolume(0);

    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() => _ready = true);
      _controller.play();
    }).catchError((_) {
      // Video belum ada / gagal dimuat -> tetap tampil bingkai kosong.
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 536 / 284, // ubah untuk mengatur tinggi bingkai
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.videoFrame, width: 5),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. Video
            if (_ready)
              FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              )
            else
              const Center(
                child: Icon(Icons.play_circle_outline, size: 56, color: Colors.white54),
              ),

            // 2. Logo (kiri atas)
            const Positioned(
              top: 10,
              left: 10,
              child: _OverlayButton(
                child: AssetOrIcon(
                  assetPath: AppAssets.logo,
                  fallbackIcon: Icons.pets,
                  size: 28,
                ),
              ),
            ),

            // 3. Tombol menu (kanan atas)
            Positioned(
              top: 10,
              right: 10,
              child: _OverlayButton(
                onTap: widget.onMenuTap,
                child: const Icon(Icons.sort, color: AppColors.dark),
              ),
            ),

            // 4. Progress bar video (bawah)
            if (_ready)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: false,
                  padding: EdgeInsets.zero,
                  colors: const VideoProgressColors(
                    playedColor: AppColors.orange,
                    bufferedColor: Colors.white24,
                    backgroundColor: Colors.white12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Kotak krem transparan di atas video (dipakai logo & menu).
class _OverlayButton extends StatelessWidget {
  const _OverlayButton({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
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

// ---------------------------------------------------------------------
// Tombol fitur yang harus DIGESER ke kanan untuk membuka fitur
//  - Geser melewati [_threshold] -> onCompleted dipanggil
//  - Dilepas sebelum itu         -> bulatan kembali ke awal
// ---------------------------------------------------------------------
class SwipeFeatureButton extends StatefulWidget {
  const SwipeFeatureButton({
    super.key,
    required this.label,
    required this.assetPath,
    required this.fallbackIcon,
    required this.color,
    required this.onCompleted,
  });

  final String label;
  final String assetPath; // ikon di dalam bulatan
  final IconData fallbackIcon; // ikon sementara jika asset belum ada
  final Color color; // warna bulatan
  final VoidCallback onCompleted; // dipanggil saat geseran berhasil

  @override
  State<SwipeFeatureButton> createState() => _SwipeFeatureButtonState();
}

class _SwipeFeatureButtonState extends State<SwipeFeatureButton> {
  static const double _height = 102; // tinggi tombol
  static const double _padding = 12; // jarak bulatan ke tepi
  static const double _threshold = 0.7; // 70% geseran dianggap berhasil

  double _dx = 0; // posisi geser saat ini
  bool _dragging = false;

  Future<void> _onDragEnd(double maxDx) async {
    if (_dx >= maxDx * _threshold) {
      // Berhasil: bulatan meluncur ke ujung, lalu buka halaman.
      setState(() {
        _dragging = false;
        _dx = maxDx;
      });
      await Future.delayed(const Duration(milliseconds: 250));
      if (!mounted) return;
      widget.onCompleted();

      // Kembalikan posisi setelah pindah halaman.
      await Future.delayed(const Duration(milliseconds: 400));
      if (mounted) setState(() => _dx = 0);
    } else {
      // Belum cukup jauh: kembali ke awal.
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
        final knobWidth = constraints.maxWidth * 0.28;
        final maxDx = constraints.maxWidth - _padding * 2 - knobWidth;
        final progress = (_dx / maxDx).clamp(0.0, 1.0);

        return Container(
          height: _height,
          decoration: BoxDecoration(
            color: AppColors.dark,
            borderRadius: BorderRadius.circular(_height / 2),
          ),
          child: Stack(
            children: [
              // Teks (memudar saat digeser)
              Center(
                child: Opacity(
                  opacity: 1 - progress,
                  child: Padding(
                    padding: EdgeInsets.only(left: knobWidth + _padding),
                    child: Text(widget.label, style: AppText.featureTitle),
                  ),
                ),
              ),

              // Bulatan yang bisa digeser
              AnimatedPositioned(
                duration: _dragging ? Duration.zero : const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                left: _padding + _dx,
                top: _padding,
                bottom: _padding,
                width: knobWidth,
                child: GestureDetector(
                  onHorizontalDragStart: (_) => setState(() => _dragging = true),
                  onHorizontalDragUpdate: (details) => setState(() {
                    _dx = (_dx + details.delta.dx).clamp(0.0, maxDx);
                  }),
                  onHorizontalDragEnd: (_) => _onDragEnd(maxDx),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular((_height - _padding * 2) / 2),
                    ),
                    child: AssetOrIcon(
                      assetPath: widget.assetPath,
                      fallbackIcon: widget.fallbackIcon,
                      size: 48,
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

// ---------------------------------------------------------------------
// Navbar bawah dengan pointer abu-abu yang meluncur ke menu aktif
// ---------------------------------------------------------------------

/// Data satu menu di navbar.
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

  static const double height = 100;
  static const double _bigRadius = 70; // lengkungan besar
  static const double _smallRadius = 10; // sudut kecil

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
          final itemWidth = constraints.maxWidth / items.length;

          return Stack(
            children: [
              // Pointer abu-abu (bergeser saat menu berpindah)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                left: currentIndex * itemWidth,
                top: 0,
                bottom: 0,
                width: itemWidth,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.navIndicator,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(_bigRadius)),
                  ),
                ),
              ),

              // Ikon + label
              Row(
                children: [
                  for (int i = 0; i < items.length; i++)
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => onTap(i),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AssetOrIcon(
                              assetPath: items[i].assetPath,
                              fallbackIcon: items[i].fallbackIcon,
                              size: 36,
                              color: AppColors.cream,
                            ),
                            const SizedBox(height: 4),
                            Text(items[i].label, style: AppText.navLabel),
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
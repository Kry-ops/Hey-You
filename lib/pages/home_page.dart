import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// =====================================================================
// BAGIAN 1 — PENGATURAN UTAMA
// Ubah pengaturan di bagian ini terlebih dahulu.
// Tidak perlu mencari angka ukuran di seluruh file.
// =====================================================================

class AppColors {
  // Warna latar dan komponen utama.
  static const background = Color(0xFFFCF1D0);
  static const dark = Color(0xFF4B4242);
  static const cream = Color(0xFFFCF1D0);

  // Warna tombol fitur.
  static const green = Color(0xFF7C9A83);
  static const orange = Color(0xFFD58A65);
  static const blue = Color(0xFF829AB1);

  // Warna indikator navbar dan bingkai header.
  static const navIndicator = Color(0xFF8C8987);
  static const videoFrame = Color(0xFF8C8987);

  // Warna latar tombol logo dan menu pada header.
  static const overlay = Color(0xFFFCF1D0);
}

class HomeLayout {
  // ---------------------------------------------------------------
  // LEBAR KOMPONEN
  // Nilai proporsi menggunakan rentang 0.0 sampai 1.0.
  // Contoh: 0.90 berarti 90% dari lebar area layar.
  // ---------------------------------------------------------------

  static const double contentWidth = 0.90; // Lebar header dan tombol.
  static const double navbarWidth = 0.92;  // Lebar navbar.
  static const double catSize = 0.65;      // Ukuran kucing terhadap layar.

  // ---------------------------------------------------------------
  // JARAK VERTIKAL
  // ---------------------------------------------------------------

  static const double topSpace = 24;       // Jarak header dari atas.
  static const double headerToButton = 40; // Jarak header ke tombol pertama.
  static const double buttonGap = 20;      // Jarak antar tombol.
  static const double bottomSpace = 12;    // Jarak navbar dari bawah.

  // ---------------------------------------------------------------
  // UKURAN KOMPONEN
  // ---------------------------------------------------------------

  static const double headerAspectRatio = 536 / 284;
  static const double buttonHeight = 62; // Tinggi tombol fitur.
  static const double navbarHeight = 60; // Tinggi navbar.

  // ---------------------------------------------------------------
  // BENTUK KOMPONEN
  // ---------------------------------------------------------------

  static const double headerRadius = 22;
  static const double headerBorder = 5;

  // ---------------------------------------------------------------
  // UKURAN IKON
  // ---------------------------------------------------------------

  static const double featureIconSize = 30;
  static const double navIconSize = 22;
  static const double overlayButtonSize = 30;

  // ---------------------------------------------------------------
  // POINTER NAVBAR (kotak abu-abu di belakang menu aktif)
  // ---------------------------------------------------------------

  static const double navIndicatorWidth = 0.68; // 0.0–1.0 dari lebar satu menu
  static const double navIndicatorRadius = 60;  // lengkung kiri atas pointer
  static const double navIndicatorRightRadius = 60; // lengkung kanan bawah pointer  
}

// Lokasi gambar dan ikon.
// Jika lokasi asset berubah, perbarui path di sini.
class AppAssets {
  static const headerImage = 'assets/videos/amo.png';
  static const logo = 'assets/home_page_assets/logo_HY_nobg.svg';

  static const iconMbti = 'assets/home_page_assets/icon_test.svg';
  static const iconPickOne = 'assets/home_page_assets/icon_pick.svg';
  static const iconPuzzle = 'assets/home_page_assets/icon_puzzle.svg';

  static const navHome = 'assets/home_page_assets/icon_home.svg';
  static const navPets = 'assets/home_page_assets/icon_pet.svg';
  static const navProfile = 'assets/home_page_assets/icon_profile.svg';

  static const cat = 'assets/home_page_assets/kucing.png';
}

// Pengaturan gaya tulisan.
class AppText {
  // Isi nama font jika font khusus sudah didaftarkan di pubspec.yaml.
  // Biarkan null untuk menggunakan font bawaan Flutter.
  static const String? mainFont = null;

  static const featureTitle = TextStyle(
    fontFamily: mainFont,
    fontSize: 15,
    color: AppColors.cream,
  );

  static const navLabel = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12,
    letterSpacing: 0,
    color: AppColors.cream,
  );
}

// =====================================================================
// BAGIAN 2 — HALAMAN HOME
// Mengatur susunan header, tombol fitur, kucing, dan navbar.
// =====================================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Indeks menu navbar yang sedang aktif.
  int _navIndex = 0;

  // Daftar menu navbar.
  // Ubah label atau asset ikon di sini.
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

  // Membuka halaman tujuan setelah tombol berhasil digeser.
  void _openPage(Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // SafeArea menjaga konten agar tidak tertutup status bar
      // atau area navigasi sistem Android.
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;

            // Lebar konten dihitung berdasarkan lebar layar.
            final contentWidth =
                screenWidth * HomeLayout.contentWidth;

            // Margin kiri dan kanan navbar dibuat seimbang.
            final navSideSpace =
                screenWidth * (1 - HomeLayout.navbarWidth) / 7;

            return SizedBox(
              // PENTING:
              // Stack harus memenuhi tinggi area layar agar navbar
              // yang menggunakan bottom benar-benar berada di bawah.
              width: screenWidth,
              height: screenHeight,
              child: Stack(
                children: [
                  // -------------------------------------------------
                  // 1. DEKORASI KUCING
                  // Berada di belakang konten dan tidak menerima tap.
                  // Ubah posisi dan ukuran melalui HomeLayout
                  // atau nilai right/bottom di bawah.
                  // -------------------------------------------------

                  Positioned(
                    right: -screenWidth * 0.17,
                    bottom: HomeLayout.navbarHeight + 20,
                    child: IgnorePointer(
                      child: AssetOrIcon(
                        assetPath: AppAssets.cat,
                        fallbackIcon: Icons.pets,
                        size: screenWidth * HomeLayout.catSize,
                      ),
                    ),
                  ),

                  // -------------------------------------------------
                  // 2. KONTEN UTAMA
                  // Dapat digulir jika tinggi layar tidak mencukupi.
                  // Navbar tetap berada di posisi bawah.
                  // -------------------------------------------------

                  SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      HomeLayout.topSpace,
                      0,

                      // Ruang tambahan mencegah tombol terakhir
                      // tertutup navbar saat halaman digulir.
                      HomeLayout.navbarHeight + 30,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: contentWidth,
                        child: Column(
                          children: [
                            // HEADER GAMBAR.
                            VideoHeader(
                              onMenuTap: () {
                                // TODO: Tambahkan aksi untuk tombol menu.
                              },
                            ),

                            // Jarak antara header dan tombol pertama.
                            SizedBox(
                              height: HomeLayout.headerToButton,
                            ),

                            // ---------------------------------------
                            // FITUR 1 — TEST MBTI
                            // ---------------------------------------

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

                            // ---------------------------------------
                            // FITUR 2 — CHOSE ONE
                            // ---------------------------------------

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

                            // ---------------------------------------
                            // FITUR 3 — PUZZLE GAME
                            // ---------------------------------------

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

                  // -------------------------------------------------
                  // 3. NAVBAR BAWAH
                  // Tetap menempel di bawah area layar.
                  // Lebar dan jaraknya dapat diatur di HomeLayout.
                  // -------------------------------------------------

                  Positioned(
                    left: navSideSpace,
                    right: navSideSpace,
                    bottom: HomeLayout.bottomSpace,
                    child: CustomBottomNav(
                      items: _navItems,
                      currentIndex: _navIndex,
                      onTap: (index) {
                        setState(() {
                          _navIndex = index;
                        });

                        // TODO:
                        // Tambahkan navigasi ke halaman Pets/Profile.
                      },
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

// =====================================================================
// BAGIAN 3 — HALAMAN SEMENTARA
// Ganti halaman ini setelah halaman fitur yang sebenarnya siap.
// =====================================================================

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.background,
      ),
      body: Center(
        child: Text('Halaman $title'),
      ),
    );
  }
}

// =====================================================================
// BAGIAN 4 — KOMPONEN GAMBAR
// Menampilkan gambar asset atau ikon pengganti jika gagal dimuat.
// =====================================================================

// =====================================================================
// PEMUAT ASSET
// Mendukung SVG dan gambar biasa seperti PNG.
// Fallback hanya muncul jika asset gagal dimuat.
// =====================================================================

class AssetOrIcon extends StatelessWidget {
  const AssetOrIcon({
    super.key,
    required this.assetPath,
    required this.fallbackIcon,
    this.size = 24,
    this.color,
  });

  final String assetPath;
  final IconData fallbackIcon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    // SVG harus dirender menggunakan flutter_svg.
    if (assetPath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        assetPath,
        width: size,
        height: size,
        fit: BoxFit.contain,

        // Isi color hanya jika memang ingin mewarnai SVG.
        colorFilter: color == null
            ? null
            : ColorFilter.mode(color!, BlendMode.srcIn),

        // Tampilkan ikon pengganti jika SVG gagal dimuat.
        placeholderBuilder: (_) => Icon(
          fallbackIcon,
          size: size,
          color: color,
        ),
      );
    }

    // PNG, JPG, dan format gambar biasa.
    return Image.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      color: color,
      errorBuilder: (_, __, ___) => Icon(
        fallbackIcon,
        size: size,
        color: color,
      ),
    );
  }
}

// =====================================================================
// BAGIAN 5 — HEADER GAMBAR
// Menampilkan gambar, logo kiri atas, dan tombol menu kanan atas.
// Nama VideoHeader dipertahankan agar pemanggilan yang sudah ada
// tidak perlu diubah, meskipun sekarang menggunakan gambar statis.
// =====================================================================

class VideoHeader extends StatelessWidget {
  const VideoHeader({super.key, this.onMenuTap});

  final VoidCallback? onMenuTap;

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
            // Gambar utama header.
            Image.asset(
              AppAssets.headerImage,
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

            // Logo di pojok kiri atas.
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

            // Tombol menu di pojok kanan atas.
            Positioned(
              top: 8,
              right: 8,
              child: _OverlayButton(
                onTap: onMenuTap,
                child: const Icon(
                  Icons.sort,
                  color: AppColors.dark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Tombol kecil dengan latar transparan untuk logo dan menu.
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

// =====================================================================
// BAGIAN 6 — TOMBOL FITUR SWIPE
// Geser bulatan ke kanan untuk membuka halaman.
// Threshold menentukan seberapa jauh tombol harus digeser.
// =====================================================================

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
  final String assetPath;
  final IconData fallbackIcon;
  final Color color;
  final VoidCallback onCompleted;

  @override
  State<SwipeFeatureButton> createState() =>
      _SwipeFeatureButtonState();
}

class _SwipeFeatureButtonState extends State<SwipeFeatureButton> {
  // Ukuran tombol diambil dari pengaturan utama.
  static const double _height = HomeLayout.buttonHeight;

  // Jarak bulatan dari tepi tombol.
  static const double _padding = 10;

  // Persentase geseran minimum agar dianggap berhasil.
  static const double _threshold = 0.70;

  double _dx = 0;
  bool _dragging = false;
  bool _opening = false;

  // Dipanggil ketika pengguna melepas bulatan.
  Future<void> _onDragEnd(double maxDx) async {
    // Mencegah pemicu ganda ketika halaman sedang dibuka.
    if (_opening) return;

    if (_dx >= maxDx * _threshold) {
      // Geseran berhasil: bulatan bergerak ke ujung kanan.
      setState(() {
        _dragging = false;
        _opening = true;
        _dx = maxDx;
      });

      await Future.delayed(
        const Duration(milliseconds: 250),
      );

      if (!mounted) return;

      // Jalankan aksi yang diberikan oleh HomePage.
      widget.onCompleted();

      // Jeda sebelum mengembalikan posisi bulatan.
      await Future.delayed(
        const Duration(milliseconds: 400),
      );

      if (!mounted) return;

      setState(() {
        _dx = 0;
        _opening = false;
      });
    } else {
      // Geseran tidak cukup jauh: kembali ke posisi awal.
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
        // Lebar bulatan menyesuaikan lebar tombol.
        final knobWidth = constraints.maxWidth * 0.28;

        // Jarak maksimal bulatan untuk mencapai ujung kanan.
        final maxDx = (
          constraints.maxWidth -
          _padding * 2 -
          knobWidth
        ).clamp(0.0, double.infinity);

        // Nilai progress digunakan untuk memudarkan teks.
        final progress = maxDx > 0
            ? (_dx / maxDx).clamp(0.0, 1.0)
            : 0.0;

        return Container(
          height: _height,
          decoration: BoxDecoration(
            color: AppColors.dark,
            borderRadius: BorderRadius.circular(_height / 2),
          ),
          child: Stack(
            children: [
              // Teks berada di tengah dan memudar ketika bulatan digeser.
              Center(
                child: Opacity(
                  opacity: 1 - progress,
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
              ),

              // Bulatan berwarna yang dapat digeser.
              AnimatedPositioned(
                duration: _dragging
                    ? Duration.zero
                    : const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                left: _padding + _dx,
                top: _padding,
                bottom: _padding,
                width: knobWidth,
                child: GestureDetector(
                  onHorizontalDragStart: _opening
                      ? null
                      : (_) {
                          setState(() {
                            _dragging = true;
                          });
                        },
                  onHorizontalDragUpdate: _opening
                      ? null
                      : (details) {
                          setState(() {
                            _dx = (_dx + details.delta.dx)
                                .clamp(0.0, maxDx);
                          });
                        },
                  onHorizontalDragEnd: _opening
                      ? null
                      : (_) => _onDragEnd(maxDx),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(
                        (_height - _padding * 2) / 2,
                      ),
                    ),
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

// =====================================================================
// BAGIAN 7 — NAVBAR BAWAH
// Indikator abu-abu bergerak mengikuti menu yang dipilih.
// =====================================================================

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

  // Tinggi navbar diatur melalui HomeLayout.
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
          final indicatorWidth = itemWidth * HomeLayout.navIndicatorWidth;

          return Stack(
            children: [
              // Pointer abu-abu: berada di tengah menu aktif.
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
                      topLeft: Radius.circular(HomeLayout.navIndicatorRadius),
                      bottomRight: Radius.circular(HomeLayout.navIndicatorRightRadius),
                    ),        
                  ),
                ),
              ),

              // Ikon dan label untuk setiap menu.
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

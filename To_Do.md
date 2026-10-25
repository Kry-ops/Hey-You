Catatan Hal hal yang harus dilakukan:

## Home Page
Nih halaman udah oke sebenarnya namun memsih memiliki beberapa kekurangan
-- Preview gambarnya belum di ubah dan belum ada animasinya
-- Kucing di bagian tengah belum memiliki animasi begerak yang membuat aplikasi ini ga terasa static

## Test MBTI
halaman ini harus dibuat, fitur pertama






import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// BAGIAN 1 — PENGATURAN UTAMA

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
  static const double featureIconSize = 30;
  static const double navIconSize = 22;
  static const double overlayButtonSize = 30;


  // POINTER NAVBAR
  static const double navIndicatorWidth = 0.68;
  static const double navIndicatorRadius = 60;
  static const double navIndicatorRightRadius = 60;
  
  // Tombool Geser
  static const double trailLabelCenter = 0.33;
}

// Lokasi gambar dan ikon.
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

    // Ikon dropdown menu.
  static const iconSettings = 'assets/home_page_assets/icon_settings.svg';
  static const iconTheme = 'assets/home_page_assets/icon_dark_theme.svg';
}

// Pengaturan gaya tulisan.
class AppText {
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

// BAGIAN 3 — HALAMAN SEMENTARA
// Digunakan untuk Settings, Change Theme, Pets, dan Profile.
// HEH BANGSAT INGAT GANTI HALAMAN DI SINI

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
        foregroundColor: AppColors.dark,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Halaman $title',
          style: const TextStyle(
            color: AppColors.dark,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

// BAGIAN 4 — PEMUAT ASSET
// Load assets dan backup fallback jika assets gagal dimuat

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
    // SVG dirender menggunakan flutter_svg.
    if (assetPath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        assetPath,
        width: size,
        height: size,
        fit: BoxFit.contain,
        colorFilter: color == null
            ? null
            : ColorFilter.mode(color!, BlendMode.srcIn),
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

// BAGIAN 6 — TOMBOL FITUR SWIPE
// Geser bulatan ke kanan untuk membuka halaman

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
 
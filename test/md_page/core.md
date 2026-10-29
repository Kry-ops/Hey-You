// app_assets.dart
class AppAssets {

    // HOME PAGE
    static const headerImage = 'assets/videos/amo.png';
    static const logo = 'assets/home_page_assets/logo_HY_nobg.svg';
    static const iconMbti = 'assets/home_page_assets/icon_test.svg';
    static const iconPickOne = 'assets/home_page_assets/icon_pick.svg';
    static const iconPuzzle = 'assets/home_page_assets/icon_puzzle.svg';
    static const navHome = 'assets/home_page_assets/icon_home.svg';
    static const navPets = 'assets/home_page_assets/icon_pet.svg';
    static const navProfile = 'assets/home_page_assets/icon_profile.svg';
    static const cat = 'assets/home_page_assets/kucing.png';

    // Icon dropdown menu.
    static const iconSettings = 'assets/home_page_assets/icon_settings.svg';
    static const iconTheme = 'assets/home_page_assets/icon_dark_theme.svg';
    static const iconMusic = 'assets/home_page_assets/icon_music.svg';

    // Icon informasi tengah
    static const iconSwipe = 'assets/home_page_assets/icon_swipe.svg';
    static const iconPanahSwipe = 'assets/home_page_assets/icon_panah_swipe.svg';

    // Daftar gambar untuk carousel header.
    static const List<String> headerImages = [
        'assets/home_page_assets/preview_assets/HeYou_.png',
        'assets/home_page_assets/preview_assets/mbti_banner.png',
        'assets/home_page_assets/preview_assets/kiryu_banner.png',
        'assets/home_page_assets/preview_assets/HeYou_.png',
        'assets/home_page_assets/preview_assets/mbti_banner.png',
        'assets/home_page_assets/preview_assets/kiryu_banner.png',
    ];

    // MBTI PAGE
    // Ikon navigasi dan tombol.
    static const String iconBack ='assets/test_mbti_page_assets/icon_panah_kembali.svg';
    static const String iconMenu ='assets/test_mbti_page_assets/icon_menu.svg';
    static const String arrowPrev ='assets/test_mbti_page_assets/icon_panah_kiri.svg';
    static const String arrowNext ='assets/test_mbti_page_assets/icon_panah_kanan.svg';

    // Ikon fitur.
    // Dekorasi.
    static const String progressLeaf ='assets/test_mbti_page_assets/daun_kiri_atas.svg';
    static const String cardLeaf ='assets/test_mbti_page_assets/daun_kiri_tengah.svg';
    // static const String cat =
    static const String plantLeft ='assets/test_mbti_page_assets/daun_kiri_bawah.svg';
    static const String plantRight ='assets/test_mbti_page_assets/daun_kanan_atas.svg';
    static const String butterfly ='assets/test_mbti_page_assets/kupu_kupu.svg';
    static const String sparkle ='assets/test_mbti_page_assets/bintang.svg';

    // Ikon untuk menu Petunjuk Tes.
    static const String iconPetunjuk = 'assets/test_mbti_page_assets/icon_tanda_seru.svg';

    // Ikon untuk menu Hai NYET.
    static const String iconHaiNyet = 'assets/test_mbti_page_assets/icon_pisang.svg';
    static const String iconMusicMBTI = 'assets/test_mbti_page_assets/icon_music.svg';
    
    // Ikon centang untuk pilihan jawaban MBTI.
    static const String iconCheck = 'assets/test_mbti_page_assets/icon_centang.svg';
}

// app_color.dart
import 'package:flutter/material.dart';

class AppColors {
  // HOME PAGE
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
  static const videoFrame = Color(0xFF4B4242);

  // Warna latar tombol logo dan menu pada header.
  static const overlay = Color(0xFFFCF1D0);



  // MBTI Page
  // Tambahkan ke class AppColors yang sudah ada.

  // Warna pilihan jawaban.
  static const Color answerIdle = Color(0xFFB99B80);

  // Warna latar progress bar.
  static const Color progressTrack = Color(0xFFE6D9B2);

  // Warna tombol NEXT saat belum menjawab.
  static const Color nextDisabled = Color(0xFFA7B5AB);

  // Warna gulungan tirai.
  static const Color curtainRoller = Color(0xFFB99B80);


}

// app_text.dart
import 'package:flutter/material.dart';
import '../core/app_colors.dart';
// Pengaturan gaya tulisan.
class AppText {
  // Home Page
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

  // Gaya teks petunjuk swipe.
  static const swipeInstruction = TextStyle(
    fontFamily: mainFont,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.1,
    color: AppColors.dark,
  );
  

  // MBTI Page
  static const question = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 18,
    height: 1.5,
    color: AppColors.cream,
  );
  static const answer = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 15,
    color: AppColors.cream,
  );
  static const counter = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 16,
    letterSpacing: 1,
    color: AppColors.dark,
  );
  static const nextLabel = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 24,
    letterSpacing: 5,
    color: AppColors.cream,
  );
  static const heading = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 20,
    color: AppColors.cream,
  );
  static const bigCode = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 48,
    letterSpacing: 6,
    fontWeight: FontWeight.bold,
    color: AppColors.cream,
  );

}

// asset_or_icon.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// PEMUAT ASSET .SVG
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


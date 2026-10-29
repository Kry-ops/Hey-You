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
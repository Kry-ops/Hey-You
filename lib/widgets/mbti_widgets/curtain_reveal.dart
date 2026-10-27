import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../utils/mbti_layout.dart';

// Animasi tirai jatuh: isi dibuka dari atas ke bawah, dan gulungan
// mengikuti ujung bawahnya. Animasi jalan sekali saat widget muncul.
// Tinggi isi tidak perlu diketahui, jadi cocok untuk kartu hasil.
class CurtainReveal extends StatefulWidget {
  const CurtainReveal({super.key, required this.child});

  final Widget child;

  @override
  State<CurtainReveal> createState() => _CurtainRevealState();
}

class _CurtainRevealState extends State<CurtainReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: MbtiConfig.curtainDuration,
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        // 0.0 = tirai tertutup, 1.0 = terbuka penuh.
        final progress = Curves.easeInOutCubic.transform(_controller.value);

        // Gulungan memudar di akhir animasi.
        final rollerOpacity =
            (1 - ((progress - 0.88) / 0.12).clamp(0.0, 1.0)).toDouble();

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Isi: hanya bagian atas setinggi `progress` yang terlihat.
            ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: progress,
                child: child,
              ),
            ),

            // Gulungan di ujung bawah bagian yang terlihat.
            if (rollerOpacity > 0)
              Positioned(
                left: -MbtiLayout.curtainRollerOverhang,
                right: -MbtiLayout.curtainRollerOverhang,
                bottom: -MbtiLayout.curtainRollerHeight / 2,
                child: Opacity(
                  opacity: rollerOpacity,
                  child: Container(
                    height: MbtiLayout.curtainRollerHeight,
                    decoration: BoxDecoration(
                      color: AppColors.curtainRoller,
                      borderRadius: BorderRadius.circular(
                        MbtiLayout.curtainRollerHeight / 2,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

// Mengecilkan isi otomatis jika lebih besar dari area yang tersedia,
// sehingga tidak overflow (dipakai kartu awal).
class ScaleToFit extends StatelessWidget {
  const ScaleToFit({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: constraints.maxWidth),
            child: child,
          ),
        );
      },
    );
  }
}
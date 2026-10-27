
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text.dart';
import '../../core/app_assets.dart';
import '../../utils/mbti_layout.dart';
import '../asset_or_icon.dart';

// =====================================================================
// KOMPONEN PILIHAN JAWABAN MBTI
// Menampilkan pilihan jawaban dengan ikon centang kustom.
// =====================================================================

class AnswerOption extends StatelessWidget {
  const AnswerOption({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Ukuran bulatan krem di sebelah kiri.
    const circleSize = MbtiLayout.answerHeight - 12;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: MbtiLayout.answerHeight,
        padding: const EdgeInsets.symmetric(horizontal: 6),

        // Warna berubah sesuai kondisi pilihan.
        decoration: BoxDecoration(
          color: selected ? AppColors.green : AppColors.answerIdle,
          borderRadius: BorderRadius.circular(
            MbtiLayout.answerHeight / 2,
          ),
        ),

        child: Row(
          children: [
            // Bulatan krem berisi ikon centang ketika dipilih.
            Container(
              width: circleSize,
              height: circleSize,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.cream,
                shape: BoxShape.circle,
              ),

              // Ikon hanya muncul jika jawaban dipilih.
              child: selected
                  ? const AssetOrIcon(
                      assetPath: AppAssets.iconCheck,
                      fallbackIcon: Icons.check_rounded,
                      size: 18,
                      color: AppColors.green,
                    )
                  : null,
            ),

            const SizedBox(width: 12),

            // Teks jawaban.
            Expanded(
              child: Text(
                label,
                style: AppText.answer,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

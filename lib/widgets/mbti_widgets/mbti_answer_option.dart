import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text.dart';
import '../../utils/mbti_layout.dart';

class AnswerOption extends StatelessWidget {
  const AnswerOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    const circleSize = MbtiLayout.answerHeight - 12;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: MbtiLayout.answerHeight,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.green : AppColors.answerIdle,
          borderRadius: BorderRadius.circular(MbtiLayout.answerHeight / 2),
        ),
        child: Row(
          children: [
            // Bulatan krem; berisi centang jika dipilih.
            Container(
              width: circleSize,
              height: circleSize,
              decoration: const BoxDecoration(
                color: AppColors.cream,
                shape: BoxShape.circle,
              ),
              child: selected
                  ? const Icon(Icons.check, size: 18, color: AppColors.green)
                  : null,
            ),
            const SizedBox(width: 12),
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
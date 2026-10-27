import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_assets.dart';
import '../../widgets/asset_or_icon.dart';


import '../../utils/mbti_layout.dart';
//  BAGIAN 5 — KOMPONEN BAGIAN ATAS
// Tombol kembali, tombol menu, dan progress soal.


class TopBar extends StatelessWidget {
  const TopBar({
    required this.onBack,
    required this.onMenu,
  });

  final VoidCallback onBack;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _SquareButton(
          assetPath: AppAssets.iconBack,
          fallbackIcon: Icons.chevron_left,
          onTap: onBack,
        ),

        // Dropdown menu.
        PopupMenuButton<String>(
          tooltip: 'Menu',
          padding: EdgeInsets.zero,
          color: AppColors.cream,
          elevation: MbtiLayout.menuElevation,
          menuPadding: const EdgeInsets.symmetric(
            vertical: MbtiLayout.menuVerticalPadding,
          ),
          constraints: const BoxConstraints(
            minWidth: MbtiLayout.menuMinWidth,
            maxWidth: MbtiLayout.menuMaxWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              MbtiLayout.menuRadius,
            ),
          ),



          // Properti textStyle dihapus karena tidak tersedia di sini.
          onSelected: (value) {
            if (value == 'help') {
              showDialog<void>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  backgroundColor: AppColors.cream,
                  surfaceTintColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  title: const Text(
                    'Petunjuk Test',
                    style: TextStyle(
                      color: AppColors.dark,
                      fontSize: 18,
                    ),
                  ),
                  content: const Text(
                    'Pilih jawaban yang paling relevan dengan dirimu. '
                    'Usahakan jawab dengan hati. Setelah itu bisa tekan '
                    'NEXT untuk lanjut (っ °Д °;)っ',
                    style: TextStyle(
                      color: AppColors.dark,
                      fontSize: 13,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      child: const Text(
                        'Mengerti',
                        style: TextStyle(
                          color: AppColors.dark,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (value == 'greeting') {
              showDialog<void>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  backgroundColor: AppColors.cream,
                  surfaceTintColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  content: const Text(
                    'Hai juga, NYET! 🫶',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.dark,
                      fontSize: 16,
                    ),
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      child: const Text(
                        'Mengerti',
                        style: TextStyle(
                          color: AppColors.dark,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },

          
          // Daftar pilihan menu beserta ikon kustom.
          itemBuilder: (context) => [
            // Menu petunjuk tes.
            const PopupMenuItem<String>(
              value: 'help',
              height: 42,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  AssetOrIcon(
                    assetPath: AppAssets.iconPetunjuk,
                    fallbackIcon: Icons.help_outline_rounded,
                    size: 20,
                    color: AppColors.dark,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Petunjuk Tes',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.dark,
                    ),
                  ),
                ],
              ),
            ),

            // Menu sapaan Hai NYET.
            const PopupMenuItem<String>(
              value: 'greeting',
              height: 42,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  AssetOrIcon(
                    assetPath: AppAssets.iconHaiNyet,
                    fallbackIcon: Icons.favorite_border_rounded,
                    size: 20,
                    color: AppColors.dark,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Hai NYET 🫶',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.dark,
                    ),
                  ),
                ],
              ),
            ),
          ],


          child: Container(
            width: MbtiLayout.topButtonSize,
            height: MbtiLayout.topButtonSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.dark,
              borderRadius: BorderRadius.circular(
                MbtiLayout.topButtonRadius,
              ),
            ),
            child: AssetOrIcon(
              assetPath: AppAssets.iconMenu,
              fallbackIcon: Icons.sort,
              size: MbtiLayout.topButtonIconSize,
              color: AppColors.cream,
            ),
          ),
        ),
      ],
    );
  }
}


class _SquareButton extends StatelessWidget {
  const _SquareButton({
    required this.assetPath,
    required this.fallbackIcon,
    required this.onTap,
  });
  final String assetPath;
  final IconData fallbackIcon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MbtiLayout.topButtonSize,
        height: MbtiLayout.topButtonSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.circular(MbtiLayout.topButtonRadius),
        ),
        child: AssetOrIcon(
          assetPath: assetPath,
          fallbackIcon: fallbackIcon,
          size: MbtiLayout.topButtonIconSize,
          color: AppColors.cream,
        ),
      ),
    );
  }
}
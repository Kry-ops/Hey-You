import 'package:flutter/material.dart';
import '../core/app_colors.dart';

// BAGIAN 3 — HALAMAN SEMENTARA
// Digunakan untuk Settings, Change Theme, Pets, dan Profile.
// HEH BANGSAT INGAT GANTI HALAMAN DI SINI

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage(this.title);

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
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

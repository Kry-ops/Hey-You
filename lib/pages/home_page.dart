
import 'dart:math' as math;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  late final AnimationController _floatController;
  late final AnimationController _particleController;
  late final AnimationController _glowController;

  @override
  void initState() {
    super.initState();

    // Animasi karakter melayang
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    // Animasi partikel background
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    // Animasi cahaya berdenyut
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    _particleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _bukaMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          decoration: const BoxDecoration(
            color: Color(0xFF191329),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'MAU NGAPAIN, PREN? 👀',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Pilih aktivitas lu di sini.',
                  style: TextStyle(color: Colors.white60),
                ),

                const SizedBox(height: 24),

                _menuItem(
                  icon: Icons.person_rounded,
                  title: 'Profil Gue',
                  subtitle: 'Lihat identitas diri lu',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pesan('Profil Gue');
                  },
                ),

                const SizedBox(height: 12),

                _menuItem(
                  icon: Icons.sentiment_very_satisfied_rounded,
                  title: 'Seberapa Unik Lu?',
                  subtitle: 'Cari tahu tingkat keabsurdan lu',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pesan('Seberapa Unik Lu?');
                  },
                ),

                const SizedBox(height: 12),

                _menuItem(
                  icon: Icons.settings_rounded,
                  title: 'Pengaturan',
                  subtitle: 'Atur pengalaman lu',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pesan('Pengaturan');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: const Color(0xFF29203D),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFFC4A7FF),
                  size: 26,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white38,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pesan(String fitur) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$fitur belum tersedia, pren! 😭'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF6D28D9),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100B1D),

      body: Stack(
        children: [
          // Background gradasi
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF25133F),
                    Color(0xFF100B1D),
                    Color(0xFF170E2A),
                  ],
                ),
              ),
            ),
          ),

          // Partikel bergerak
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _particleController,
              builder: (context, child) {
                return CustomPaint(
                  painter: _ParticlePainter(
                    progress: _particleController.value,
                  ),
                );
              },
            ),
          ),

          // Cahaya di belakang karakter
          Center(
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (context, child) {
                final glowSize =
                    230.0 + (_glowController.value * 35);

                return Container(
                  width: glowSize,
                  height: glowSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF8B5CF6).withOpacity(
                      0.06 + (_glowController.value * 0.08),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF8B5CF6)
                            .withOpacity(0.12),
                        blurRadius: 80,
                        spreadRadius: 20,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Konten utama
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 18,
              ),
              child: Column(
                children: [
                  // Header
                  Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: const Icon(
                          Icons.bubble_chart_rounded,
                          color: Color(0xFFC4A7FF),
                          size: 25,
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Text(
                        'HEY, YOU!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),

                      const Spacer(),

                      const Icon(
                        Icons.auto_awesome_rounded,
                        color: Color(0xFFC4A7FF),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Area karakter
                  Expanded(
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _floatController,
                        builder: (context, child) {
                          final t = _floatController.value;

                          return Transform.translate(
                            offset: Offset(
                              math.sin(t * math.pi * 2) * 7,
                              -18 + (t * 36),
                            ),
                            child: Transform.rotate(
                              angle: math.sin(t * math.pi * 2) * 0.045,
                              child: child,
                            ),
                          );
                        },
                        child: const _GoofyMascot(),
                      ),
                    ),
                  ),

                  // Teks di bawah karakter
                  const Text(
                    'HEY, YOU! 👋',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Akhirnya sampai juga di sini, pren.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFD0C5E8),
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Your existence is questionable. 💀',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF9584B5),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Petunjuk interaksi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.touch_app_rounded,
                        size: 17,
                        color: Colors.white.withOpacity(0.55),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Psst... coba cek menu lu.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.55),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 70),
                ],
              ),
            ),
          ),
        ],
      ),

      // Floating menu
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _bukaMenu,
        backgroundColor: const Color(0xFF9B72F2),
        foregroundColor: Colors.white,
        elevation: 10,
        icon: const Icon(Icons.grid_view_rounded),
        label: const Text(
          'MENU',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat,
    );
  }
}

// =====================================================
// MASKOT GOOFY: ILUSTRASI 2D DENGAN EFEK KEDALAMAN
// =====================================================

class _GoofyMascot extends StatelessWidget {
  const _GoofyMascot();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      height: 270,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Bayangan di lantai
          Positioned(
            bottom: 12,
            child: Container(
              width: 120,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF9B72F2)
                        .withOpacity(0.2),
                    blurRadius: 25,
                    spreadRadius: 8,
                  ),
                ],
              ),
            ),
          ),

          // Tanduk kiri
          Positioned(
            top: 17,
            left: 57,
            child: Transform.rotate(
              angle: -0.4,
              child: Container(
                width: 30,
                height: 49,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFC4A7FF),
                      Color(0xFF8051DB),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),

          // Tanduk kanan
          Positioned(
            top: 17,
            right: 57,
            child: Transform.rotate(
              angle: 0.4,
              child: Container(
                width: 30,
                height: 49,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFC4A7FF),
                      Color(0xFF8051DB),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),

          // Badan dan kepala maskot
          Positioned(
            top: 37,
            child: Container(
              width: 190,
              height: 195,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFD6BFFF),
                    Color(0xFF9B72F2),
                    Color(0xFF6638BD),
                  ],
                  stops: [0.0, 0.48, 1.0],
                ),
                borderRadius: BorderRadius.circular(75),
                border: Border.all(
                  color: const Color(0xFFE5D8FF),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B5CF6)
                        .withOpacity(0.3),
                    blurRadius: 35,
                    spreadRadius: 2,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Kilau di kepala
                  Positioned(
                    top: 15,
                    left: 24,
                    child: Container(
                      width: 43,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  // Mata kiri
                  Positioned(
                    top: 61,
                    left: 36,
                    child: _eye(),
                  ),

                  // Mata kanan
                  Positioned(
                    top: 61,
                    right: 36,
                    child: _eye(),
                  ),

                  // Pipi kiri
                  Positioned(
                    top: 111,
                    left: 22,
                    child: _cheek(),
                  ),

                  // Pipi kanan
                  Positioned(
                    top: 111,
                    right: 22,
                    child: _cheek(),
                  ),

                  // Mulut goofy
                  Positioned(
                    top: 112,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 42,
                        height: 29,
                        decoration: const BoxDecoration(
                          color: Color(0xFF392052),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(5),
                            bottom: Radius.circular(22),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 25,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFB7D5),
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Bintik di wajah
                  Positioned(
                    top: 38,
                    right: 30,
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      color: Colors.white.withOpacity(0.75),
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tangan kiri
          Positioned(
            left: 2,
            top: 125,
            child: Transform.rotate(
              angle: -0.7,
              child: Container(
                width: 42,
                height: 25,
                decoration: BoxDecoration(
                  color: const Color(0xFFA782F6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFD6BFFF),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),

          // Tangan kanan
          Positioned(
            right: 2,
            top: 140,
            child: Transform.rotate(
              angle: 0.7,
              child: Container(
                width: 42,
                height: 25,
                decoration: BoxDecoration(
                  color: const Color(0xFFA782F6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFD6BFFF),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),

          // Bintang dekorasi
          const Positioned(
            top: 72,
            left: 5,
            child: Icon(
              Icons.star_rounded,
              color: Color(0xFFFFD166),
              size: 25,
            ),
          ),

          const Positioned(
            top: 54,
            right: 5,
            child: Icon(
              Icons.auto_awesome,
              color: Color(0xFFFFD166),
              size: 20,
            ),
          ),

          const Positioned(
            bottom: 40,
            right: 10,
            child: Icon(
              Icons.favorite_rounded,
              color: Color(0xFFFF8FB8),
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _eye() {
    return Container(
      width: 47,
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 7,
            bottom: 8,
            child: Container(
              width: 25,
              height: 33,
              decoration: BoxDecoration(
                color: const Color(0xFF30203D),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),

          Positioned(
            top: 9,
            right: 10,
            child: Container(
              width: 9,
              height: 9,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cheek() {
    return Container(
      width: 23,
      height: 12,
      decoration: BoxDecoration(
        color: const Color(0xFFFFA6CF).withOpacity(0.75),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

// =====================================================
// BACKGROUND PARTIKEL
// =====================================================

class _ParticlePainter extends CustomPainter {
  final double progress;

  _ParticlePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (int i = 0; i < 45; i++) {
      final x = ((i * 73.0) % size.width);
      final startY = ((i * 97.0) % size.height);

      final y = (startY -
              progress * (size.height + 30) +
              size.height * 2) %
          size.height;

      final radius = 1.0 + ((i % 4) * 0.65);

      final opacity = 0.15 + ((i % 5) * 0.12);

      paint.color = i % 3 == 0
          ? Colors.pinkAccent.withOpacity(opacity)
          : const Color(0xFFC4A7FF).withOpacity(opacity);

      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

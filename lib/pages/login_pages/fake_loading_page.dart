
import 'package:flutter/material.dart';
import '../home_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FakeLoadingPage extends StatefulWidget {
  final String nama;
  final double tinggi;

  const FakeLoadingPage({
    super.key,
    required this.nama,
    required this.tinggi,
  });

  @override
  State<FakeLoadingPage> createState() =>
      _FakeLoadingPageState();
}

class _FakeLoadingPageState extends State<FakeLoadingPage> {
  String get ejekan {
    final tinggi = widget.tinggi;

    if (tinggi <= 143) {
      return 'Botol yakult juga sujud sama pendeknya lu';
    } else if (tinggi == 144) {
      return 'WKWKWKKW 144, 144P?';
    } else if (tinggi < 150) {
      return 'Setara tinggi gorila betina, Keren';
    } else if (tinggi < 155) {
      return 'Segini 🤏, asli ga boong';
    } else if (tinggi < 160) {
      return 'Pendeknyooooo';
    } else if (tinggi < 170) {
      return 'Oke lah, Not bad';
    } else if (tinggi < 180) {
      return 'Tinggi orang-orang KEREN';
    } else if (tinggi < 185) {
      return 'Atlet kah kau?';
    } else {
      return 'Tiang WIFI depan rumah';
    }
  }

  @override
  void initState() {
    super.initState();
    _mulaiLoading();
  }

  Future<void> _mulaiLoading() async {
    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [              
              LoadingAnimationWidget.halfTriangleDot(
                color: Colors.deepPurple,
                size: 50,
              ), 

              const SizedBox(height: 32),
              Text(
                'Tinggi Badan ${widget.nama} ${widget.tinggi}CM',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 16),
              Text(
                ejekan,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),

              const SizedBox(height: 12),
              Text(
                'Loading Bentar Pren',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

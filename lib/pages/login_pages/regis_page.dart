import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:hey_you/pages/login_pages/fake_loading_page.dart';

enum JenisKelamin {
  cowok,
  cewek,
  dinosaur,
  car,
  table,
  not,
}

enum HewanFavorit {
  kucing,
  anjing,
  teman,
  developer,
  kursi,
  pohon,
}

enum Pekerjaan {
  mahasiswa,
  hero,
  asli,
  pengangguran,
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() =>
      _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _tinggiController = TextEditingController();

  JenisKelamin? _jenisKelamin;
  HewanFavorit? _hewanFavorit;
  Pekerjaan? _pekerjaan;

  InputDecoration _inputStyle({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.deepPurple),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE5E0ED),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.deepPurple,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
    );
  }

  void _daftar() {
    if (!_formKey.currentState!.validate()) return;

    final nama = _namaController.text.trim();

    final tinggi = double.tryParse(
      _tinggiController.text.trim().replaceAll(',', '.'),
    );

    if (tinggi == null || tinggi <= 0) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FakeLoadingPage(
          nama: nama,
          tinggi: tinggi,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _tinggiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // HEADER
                Container(
                  height: 190,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF512DA8),
                        Color(0xFF9575CD),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withValues(
                          alpha: 0.20,
                        ),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        pause: const Duration(milliseconds: 600),
                        animatedTexts: [
                          FadeAnimatedText('HEY!'),
                          FadeAnimatedText('HEY, YOU!'),
                          FadeAnimatedText('YEAH YOU!'),
                          FadeAnimatedText('MONYET 😜'),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),
                Center(
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF292333),
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        WavyAnimatedText('Alooooo'),
                        WavyAnimatedText('Mat Datang Prenn'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                const Text(
                  'Formulir resmi dari FBI untuk mendata '
                  'calon peminjam pinjol. Tenang, ini cuma '
                  'buat seru-seruan kok 😂',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 16,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _namaController,
                        textCapitalization: TextCapitalization.words,
                        decoration: _inputStyle(
                          label: 'Nama kamu siapa?',
                          hint: 'Developer Ganteng Pro Max',
                          icon: Icons.person_outline,
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Nama wajib diisi, pren!';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 18),
                      DropdownButtonFormField<JenisKelamin>(
                        value: _jenisKelamin,
                        isExpanded: true,
                        decoration: _inputStyle(
                          label: 'Jenis kelamin?',
                          hint: 'Pilih identitas',
                          icon: Icons.person_search_outlined,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: JenisKelamin.cowok,
                            child: Text('Laki-laki'),
                          ),
                          DropdownMenuItem(
                            value: JenisKelamin.cewek,
                            child: Text('Perempuan'),
                          ),
                          DropdownMenuItem(
                            value: JenisKelamin.dinosaur,
                            child: Text('Dinosaurus 🦖'),
                          ),
                          DropdownMenuItem(
                            value: JenisKelamin.car,
                            child: Text('Mobil 🚗'),
                          ),
                          DropdownMenuItem(
                            value: JenisKelamin.table,
                            child: Text('Meja 🪑'),
                          ),
                          DropdownMenuItem(
                            value: JenisKelamin.not,
                            child: Text('Lainnya'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() => _jenisKelamin = value);
                        },
                        validator: (value) {
                          return value == null
                              ? 'Pilih salah satu dulu'
                              : null;
                        },
                      ),

                      const SizedBox(height: 18),
                      DropdownButtonFormField<HewanFavorit>(
                        value: _hewanFavorit,
                        isExpanded: true,
                        decoration: _inputStyle(
                          label: 'Hewan favorit?',
                          hint: 'Jawab jujur!',
                          icon: Icons.pets_outlined,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: HewanFavorit.kucing,
                            child: Text('Cuking 🐱'),
                          ),
                          DropdownMenuItem(
                            value: HewanFavorit.anjing,
                            child: Text('Jingan 🐶'),
                          ),
                          DropdownMenuItem(
                            value: HewanFavorit.teman,
                            child: Text('Your Friend 🗿'),
                          ),
                          DropdownMenuItem(
                            value: HewanFavorit.kursi,
                            child: Text('Kursi'),
                          ),
                          DropdownMenuItem(
                            value: HewanFavorit.pohon,
                            child: Text('Pohon mangga 🌳'),
                          ),
                          DropdownMenuItem(
                            value: HewanFavorit.developer,
                            child: Text('Developer ganteng 😎'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() => _hewanFavorit = value);
                        },
                        validator: (value) {
                          return value == null
                              ? 'Pilih hewan favoritmu'
                              : null;
                        },
                      ),

                      const SizedBox(height: 18),
                      DropdownButtonFormField<Pekerjaan>(
                        value: _pekerjaan,
                        isExpanded: true,
                        decoration: _inputStyle(
                          label: 'Pekerjaan kamu apa?',
                          hint: 'Pilih pekerjaan',
                          icon: Icons.work_outline,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: Pekerjaan.mahasiswa,
                            child: Text('Mahasiswa 🎓'),
                          ),
                          DropdownMenuItem(
                            value: Pekerjaan.pengangguran,
                            child: Text('Pengangguran LVL 99'),
                          ),
                          DropdownMenuItem(
                            value: Pekerjaan.hero,
                            child: Text('Badut cinta 🤡'),
                          ),
                          DropdownMenuItem(
                            value: Pekerjaan.asli,
                            child: Text(
                              'Mengagumi developer 24/7',
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() => _pekerjaan = value);
                        },
                        validator: (value) {
                          return value == null
                              ? 'Pilih pekerjaanmu'
                              : null;
                        },
                      ),

                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _tinggiController,
                        keyboardType:
                            const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: _inputStyle(
                          label: 'Tinggi badan (cm)',
                          hint: 'Contoh: 150',
                          icon: Icons.height,
                        ),
                        validator: (value) {
                          final tinggi = double.tryParse(
                            (value ?? '').trim().replaceAll(',', '.'),
                          );

                          if (tinggi == null || tinggi <= 0) {
                            return 'Masukkan tinggi yang valid';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 26),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton.icon(
                          onPressed: _daftar,
                          icon: const Icon(
                            Icons.login_rounded,
                          ),
                          label: const Text(
                            'MASUK',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                const Text(
                  '© FBI abal-abal • Data kamu aman '
                  '(katanya) 😂',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

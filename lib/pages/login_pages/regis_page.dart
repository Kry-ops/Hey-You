
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _namaController = TextEditingController();
  final _jenisController = TextEditingController();
  final _tinggiController = TextEditingController();
  final _hewanController = TextEditingController();

  void _daftar() {
    final nama = _namaController.text.trim();
    final tinggi = double.tryParse(_tinggiController.text);

    if (nama.isEmpty || tinggi == null ||
        tinggi <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Isi yang benar tuh data jing'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('OK thank'),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _jenisController.dispose();
    _tinggiController.dispose();
    _hewanController.dispose();
    super.dispose();
  }

// Dipercaya baris kode ini untuk form enum AKA pilih salah satu
JenisKelamin? _jenisKelamin;
HewanFavorit? _hewanFavorit;
Pekerjaan? _pekerjaan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

              const SizedBox(height: 2),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 190,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 190,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withValues(alpha: 0.25),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                      ),
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          pause: const Duration(milliseconds: 500),
                          animatedTexts: [
                            FadeAnimatedText('HEY!'),
                            FadeAnimatedText('HEY, YOU!'),
                            FadeAnimatedText('YEAH YOU!'),
                            FadeAnimatedText('MONYET😜'),
                          ],
                          onTap: () {
                            debugPrint('Hey, You logo!');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

                const SizedBox(height: 36),
                SizedBox(
                width: double.infinity,
                height: 40,
                child: Center(
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        WavyAnimatedText('Alooooo'),
                        WavyAnimatedText('Mat Datang Prenn'),
                      ],
                      onTap: () {
                        debugPrint('Aloo, mat datang ');
                      },
                    ),
                  ),
                ),
              ),

                const SizedBox(height: 8),
                const Text(
                  'Dipercaya FBI membutuhkan data diri kalian untuk mengambil pinjaman online ༼ つ ◕_◕ ༽つ',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 32),
                TextField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    labelText: 'Nama you siape?',
                    hintText: 'Developer Ganteng Pro Max Special Edition',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),

                const SizedBox(height: 16),
                DropdownButtonFormField<JenisKelamin>(
                  value: _jenisKelamin,
                  decoration: InputDecoration(
                    labelText: 'Jenis kelamin?',
                    hintText: 'Pilih jenis kelamin',
                    prefixIcon: const Icon(Icons.transgender),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
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
                      child: Text('Dinosaurus'),
                    ),
                    DropdownMenuItem(
                      value: JenisKelamin.car,
                      child: Text('Mobil'),
                    ),
                    DropdownMenuItem(
                      value: JenisKelamin.table,
                      child: Text('Meja'),
                    ),
                    DropdownMenuItem(
                      value: JenisKelamin.not,
                      child: Text('Transgender = Idiot'),
                    ),
                  ],
                  onChanged: (JenisKelamin? value) {
                    setState(() {
                      _jenisKelamin = value;
                    });
                  },
                ),

                const SizedBox(height: 16),
                DropdownButtonFormField<HewanFavorit>(
                  value: _hewanFavorit,
                  decoration: InputDecoration(
                    labelText: 'Hewan Favorit? (jawab jujur!)',
                    hintText: 'Pilih Buru',
                    prefixIcon: const Icon(Icons.pets),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: HewanFavorit.kucing,
                      child: Text('Cuking'),
                    ),
                    DropdownMenuItem(
                      value: HewanFavorit.anjing,
                      child: Text('Jingan'),
                    ),
                    DropdownMenuItem(
                      value: HewanFavorit.teman,
                      child: Text('Your Friend'),
                    ),
                    DropdownMenuItem(
                      value: HewanFavorit.kursi,
                      child: Text('Kursi'),
                    ),
                    DropdownMenuItem(
                      value: HewanFavorit.pohon,
                      child: Text('Pohon Mangga'),
                    ),
                    DropdownMenuItem(
                      value: HewanFavorit.developer,
                      child: Text('Developer Ganteng'),
                    ),
                  ],
                  onChanged: (HewanFavorit? value) {
                    setState(() {
                      _hewanFavorit = value;
                    });
                  },
                ),

                const SizedBox(height: 16),
                DropdownButtonFormField<Pekerjaan>(
                  value: _pekerjaan,
                  decoration: InputDecoration(
                    labelText: 'Pekerjaan lu ape?',
                    hintText: 'Pilih Buru',
                    prefixIcon: const Icon(Icons.work),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: Pekerjaan.mahasiswa,
                      child: Text('Mahasiswa'),
                    ),
                    DropdownMenuItem(
                      value: Pekerjaan.pengangguran,
                      child: Text('Pengangguran LVL 99'),
                    ),
                    DropdownMenuItem(
                      value: Pekerjaan.hero,
                      child: Text('Jadi badut cwk orang'),
                    ),
                    DropdownMenuItem(
                      value: Pekerjaan.asli,
                      child: Text('Mengagumi Developer Ganteng 24/7'),
                    ),
                  ],
                  onChanged: (Pekerjaan? value) {
                    setState(() {
                      _pekerjaan = value;
                    });
                  },
                ),
                
                const SizedBox(height: 16),
                TextField(
                  controller: _tinggiController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Tinggi badan berapa? (cm) (Kejujuran itu PENTING)',
                    hintText: 'Contoh: 150 (pendek inimah)',
                    prefixIcon: const Icon(Icons.height),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _daftar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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

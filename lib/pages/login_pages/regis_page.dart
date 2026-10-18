
import 'package:flutter/material.dart';

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

  DateTime? _tanggalLahir;

  Future<void> _pilihTanggalLahir() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime(2005, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (tanggal != null) {
      setState(() {
        _tanggalLahir = tanggal;
      });
    }
  }

  void _daftar() {
    final nama = _namaController.text.trim();
    final tinggi = double.tryParse(_tinggiController.text);

    if (nama.isEmpty || _tanggalLahir == null || tinggi == null ||
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
                const Icon(
                  Icons.person_add_alt_sharp,
                  size: 72,
                  color: Colors.deepPurple,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Alooo, Mat Datang',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
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
                    hintText: 'piwpiw',
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
                    labelText: 'Hewan Favorit?',
                    hintText: 'Pilih SASASATU',
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
                TextField(
                  controller: _tinggiController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Tinggi badan berapa? (cm)',
                    hintText: 'Contoh: 150 (pendek inimah)',
                    prefixIcon: const Icon(Icons.height),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),

                const SizedBox(height: 16),
                InkWell(
                  onTap: _pilihTanggalLahir,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Tanggal lahir',
                      prefixIcon: const Icon(Icons.calendar_month),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    child: Text(
                      _tanggalLahir == null
                          ? 'Lahir kapan?'
                          : '${_tanggalLahir!.day.toString().padLeft(2, '0')}/'
                            '${_tanggalLahir!.month.toString().padLeft(2, '0')}/'
                            '${_tanggalLahir!.year}',
                    ),
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

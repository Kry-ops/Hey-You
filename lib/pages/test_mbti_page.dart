import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_text.dart';
import '../widgets/asset_or_icon.dart';


// =====================================================================
// BAGIAN 1 — PENGATURAN UTAMA
// Ubah warna, ukuran, posisi dekorasi, dan lokasi asset di sini.
// =====================================================================

class MbtiColors {
  static const answerIdle = Color(0xFFB99B80); // pilihan jawaban belum dipilih
  static const progressTrack = Color(0xFFE6D9B2); // latar progress bar
  static const nextDisabled = Color(0xFFA7B5AB); // tombol NEXT sebelum menjawab
}

class MbtiConfig {
  // Jeda istirahat muncul setiap sekian soal.
  static const int restEvery = 20;

  // Pilihan jawaban, urut dari yang paling setuju.
  static const List<String> answerLabels = [
    'Sangat Setuju',
    'Setuju',
    'Netral',
    'Tidak Setuju',
    'Sangat Tidak Setuju',
  ];

  // Tulisan pada tombol bawah.
  static const String nextLabel = 'NEXT';
  static const String finishLabel = 'SELESAI'; // dipakai di soal terakhir
  static const String restLabel = 'LANJUT'; // dipakai di layar istirahat
}

// Posisi satu dekorasi: right dan size dihitung dari LEBAR layar,
// bottom dihitung dari TINGGI layar (nilai 0.0 sampai 1.0).
class DecoSpot {
  const DecoSpot(this.right, this.bottom, this.size);

  final double right;
  final double bottom;
  final double size;
}

class MbtiLayout {
  // ---------------------------------------------------------------
  // LEBAR & JARAK
  // ---------------------------------------------------------------
  static const double contentWidth = 0.90; // lebar konten
  static const double topSpace = 12; // jarak tombol atas dari atas layar
  static const double topToProgress = 16; // tombol atas ke progress
  static const double progressToCard = 14; // progress ke kartu soal
  static const double bottomSpace = 12; // jarak tombol NEXT dari bawah

  // ---------------------------------------------------------------
  // KOMPONEN
  // ---------------------------------------------------------------
  static const double topButtonSize = 40;
  static const double topButtonRadius = 10;
  static const double progressHeight = 6;
  static const double progressLeafSize = 28;
  static const double cardRadius = 42; // lengkung sudut atas kartu
  static const double cardCurveDepth = 26; // lengkung bawah kartu
  static const double cardDotSize = 24; // bulatan kecil di kiri atas kartu
  static const double answerHeight = 45;
  static const double answerGap = 10;
  static const double nextBarHeight = 56;
  static const double nextBarWidth = 0.90;

  // ---------------------------------------------------------------
  // DEKORASI (kucing, tanaman, kupu-kupu, kilau)
  // ---------------------------------------------------------------
  static const double catSize = 0.85;
  static const double catRight = -0.17;
  static const double plantLeftSize = 0.50;
  static const double plantRightSize = 0.28;
  static const double butterflySize = 0.10;
  static const double butterflyRight = 0.20;
  static const double butterflyBottom = 0.26;
  static const List<DecoSpot> sparkles = [
    DecoSpot(0.40, 0.27, 0.05),
    DecoSpot(0.43, 0.235, 0.03),
    DecoSpot(0.34, 0.19, 0.04),
    DecoSpot(0.37, 0.39, 0.04),
  ];
}

// Lokasi gambar dan ikon. Sesuaikan dengan nama file asset-mu.
class MbtiAssets {
  static const iconBack = 'assets/test_mbti_page_assets/icon_panah_kembali.svg';
  static const iconMenu = 'assets/test_mbti_page_assets/icon_menu.svg';
  static const arrowPrev = 'assets/test_mbti_page_assets/icon_panah_kiri.svg';
  static const arrowNext = 'assets/test_mbti_page_assets/icon_panah_kanan.svg';

  static const progressLeaf = 'assets/test_mbti_page_assets/daun_kiri_atas.svg';
  static const cardLeaf = 'assets/test_mbti_page_assets/daun_kiri_tengah.svg';

  static const cat = 'assets/test_mbti_page_assets/kucing.png';
  static const plantLeft = 'assets/test_mbti_page_assets/daun_kiri_bawah.svg';
  static const plantRight = 'assets/test_mbti_page_assets/daun_kanan_atas.svg';
  static const butterfly = 'assets/test_mbti_page_assets/kupu_kupu.svg';
  static const sparkle = 'assets/test_mbti_page_assets/bintang.svg';
}

// Gaya tulisan halaman ini.
class MbtiText {
  static const question = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 15,
    height: 1.5,
    color: AppColors.cream,
  );

  static const answer = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 14,
    color: AppColors.cream,
  );

  static const counter = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 13,
    letterSpacing: 1,
    color: AppColors.dark,
  );

  static const nextLabel = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 22,
    letterSpacing: 2,
    color: AppColors.cream,
  );

  static const heading = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 20,
    color: AppColors.cream,
  );

  static const bigCode = TextStyle(
    fontFamily: AppText.mainFont,
    fontSize: 48,
    letterSpacing: 6,
    fontWeight: FontWeight.bold,
    color: AppColors.cream,
  );
}

// =====================================================================
// BAGIAN 2 — DAFTAR SOAL
// 4 kelompok x 15 soal = 60 soal. Soal ditampilkan selang-seling
// antar kelompok. Jumlah total otomatis mengikuti isi daftar.
//
// Parameter kedua = huruf MBTI yang DIDUKUNG jika user menjawab "Setuju".
//   E / I = Extrovert / Introvert     S / N = Sensing / Intuition
//   T / F = Thinking / Feeling        J / P = Judging / Perceiving
// =====================================================================

class MbtiQuestion {
  const MbtiQuestion(this.text, this.letter);

  final String text;
  final String letter;
}

const List<MbtiQuestion> _questionsEI = [
  MbtiQuestion('Energiku terasa cepat habis setelah bertemu banyak orang baru.', 'I'),
  MbtiQuestion('Aku mudah memulai obrolan dengan orang yang baru kukenal.', 'E'),
  MbtiQuestion('Aku lebih suka menghabiskan akhir pekan sendirian atau bersama satu-dua orang dekat.', 'I'),
  MbtiQuestion('Berada di tengah keramaian membuatku bersemangat.', 'E'),
  MbtiQuestion('Aku perlu waktu sendiri untuk memulihkan tenaga setelah acara ramai.', 'I'),
  MbtiQuestion('Aku biasanya berpikir sambil berbicara dengan orang lain.', 'E'),
  MbtiQuestion('Aku lebih nyaman mendengarkan daripada menjadi pusat perhatian.', 'I'),
  MbtiQuestion('Aku punya banyak teman dan senang menambah kenalan baru.', 'E'),
  MbtiQuestion('Aku berpikir matang dulu sebelum bicara dalam diskusi kelompok.', 'I'),
  MbtiQuestion('Aku cepat akrab dalam situasi sosial yang baru.', 'E'),
  MbtiQuestion('Aku merasa lebih produktif saat bekerja sendiri.', 'I'),
  MbtiQuestion('Aku sering menjadi orang yang memulai ajakan berkumpul.', 'E'),
  MbtiQuestion('Percakapan ringan dengan orang asing terasa melelahkan bagiku.', 'I'),
  MbtiQuestion('Aku mudah bosan kalau terlalu lama sendirian.', 'E'),
  MbtiQuestion('Aku lebih suka punya sedikit teman dekat daripada banyak kenalan.', 'I'),
];

const List<MbtiQuestion> _questionsSN = [
  MbtiQuestion('Aku lebih percaya pada fakta dan pengalaman nyata daripada firasat.', 'S'),
  MbtiQuestion('Aku sering memikirkan berbagai kemungkinan di masa depan.', 'N'),
  MbtiQuestion('Aku lebih suka petunjuk yang jelas dan langkah-langkah yang konkret.', 'S'),
  MbtiQuestion('Aku mudah tertarik pada ide-ide baru yang tidak biasa.', 'N'),
  MbtiQuestion('Aku memperhatikan detail-detail kecil di sekitarku.', 'S'),
  MbtiQuestion('Aku suka mencari makna atau pola di balik suatu kejadian.', 'N'),
  MbtiQuestion('Aku lebih nyaman dengan cara kerja yang sudah terbukti berhasil.', 'S'),
  MbtiQuestion('Aku sering melamun atau membayangkan hal yang belum terjadi.', 'N'),
  MbtiQuestion('Aku lebih suka membicarakan hal-hal yang nyata dan praktis.', 'S'),
  MbtiQuestion('Aku suka berpikir dengan analogi atau perumpamaan.', 'N'),
  MbtiQuestion('Aku belajar paling baik lewat praktik langsung.', 'S'),
  MbtiQuestion('Aku lebih tertarik pada gambaran besar daripada rincian.', 'N'),
  MbtiQuestion('Aku lebih mengandalkan pengalaman nyata saat mengambil keputusan.', 'S'),
  MbtiQuestion('Aku mudah bosan dengan rutinitas dan ingin mencoba cara baru.', 'N'),
  MbtiQuestion('Aku menyukai hal-hal yang bisa dilihat, disentuh, dan dibuktikan.', 'S'),
];

const List<MbtiQuestion> _questionsTF = [
  MbtiQuestion('Saat mengambil keputusan, aku mengutamakan logika daripada perasaan.', 'T'),
  MbtiQuestion('Aku mudah ikut merasakan perasaan orang lain.', 'F'),
  MbtiQuestion('Aku lebih suka kritik yang jujur dan apa adanya.', 'T'),
  MbtiQuestion('Menjaga keharmonisan sama pentingnya dengan menjadi benar.', 'F'),
  MbtiQuestion('Aku cenderung menilai suatu masalah secara objektif.', 'T'),
  MbtiQuestion('Aku sering mempertimbangkan perasaan orang sebelum berbicara.', 'F'),
  MbtiQuestion('Bagiku bersikap adil lebih penting daripada bersikap belas kasihan.', 'T'),
  MbtiQuestion('Aku mudah tersentuh oleh cerita orang lain.', 'F'),
  MbtiQuestion('Aku tetap bisa berpikir jernih saat orang di sekitarku sedang emosional.', 'T'),
  MbtiQuestion('Nilai-nilai pribadi sangat memengaruhi keputusanku.', 'F'),
  MbtiQuestion('Aku suka berdebat untuk menguji sebuah gagasan.', 'T'),
  MbtiQuestion('Aku lebih suka menolong orang daripada menganalisis masalahnya.', 'F'),
  MbtiQuestion('Aku menilai sesuatu dari kebenarannya, bukan dari rasa suka.', 'T'),
  MbtiQuestion('Aku merasa tidak enak jika harus menolak permintaan orang lain.', 'F'),
  MbtiQuestion('Aku bisa mengambil keputusan tegas meskipun ada yang kecewa.', 'T'),
];

const List<MbtiQuestion> _questionsJP = [
  MbtiQuestion('Aku suka membuat rencana sebelum memulai sesuatu.', 'J'),
  MbtiQuestion('Aku lebih suka mengikuti arus daripada terikat jadwal.', 'P'),
  MbtiQuestion('Aku merasa tenang kalau pekerjaan selesai jauh sebelum tenggat.', 'J'),
  MbtiQuestion('Aku sering menyelesaikan tugas mendekati tenggat waktu.', 'P'),
  MbtiQuestion('Aku suka barang dan jadwalku tertata rapi.', 'J'),
  MbtiQuestion('Aku senang membiarkan pilihan tetap terbuka selama mungkin.', 'P'),
  MbtiQuestion('Aku tidak nyaman jika rencanaku tiba-tiba berubah.', 'J'),
  MbtiQuestion('Aku menikmati kejutan dan hal-hal yang spontan.', 'P'),
  MbtiQuestion('Aku cepat mengambil keputusan lalu langsung menjalankannya.', 'J'),
  MbtiQuestion('Aku lebih suka menyesuaikan diri di tengah jalan daripada mengikuti rencana awal.', 'P'),
  MbtiQuestion('Aku memakai daftar tugas atau kalender untuk mengatur kegiatanku.', 'J'),
  MbtiQuestion('Aku bisa bekerja dengan baik tanpa jadwal yang pasti.', 'P'),
  MbtiQuestion('Aku merasa lega setelah suatu keputusan benar-benar ditetapkan.', 'J'),
  MbtiQuestion('Aku sering baru mulai mengerjakan sesuatu saat sedang ingin.', 'P'),
  MbtiQuestion('Aku tidak suka menunda pekerjaan.', 'J'),
];

// Daftar akhir yang dipakai halaman: soal dari 4 kelompok diselang-seling.
final List<MbtiQuestion> mbtiQuestions = _interleave(
  [_questionsEI, _questionsSN, _questionsTF, _questionsJP],
);

List<MbtiQuestion> _interleave(List<List<MbtiQuestion>> groups) {
  final result = <MbtiQuestion>[];
  final longest = groups.map((g) => g.length).reduce((a, b) => a > b ? a : b);

  for (int i = 0; i < longest; i++) {
    for (final group in groups) {
      if (i < group.length) result.add(group[i]);
    }
  }
  return result;
}

// =====================================================================
// BAGIAN 3 — HASIL (16 TIPE MBTI) DAN PERHITUNGAN
// =====================================================================

class MbtiResult {
  const MbtiResult(this.title, this.description);

  final String title;
  final String description;
}

const Map<String, MbtiResult> mbtiResults = {
  'INTJ': MbtiResult('Sang Arsitek', 'Pemikir strategis dengan rencana jangka panjang. Mandiri, analitis, dan selalu mencari cara paling efisien untuk mencapai tujuan.'),
  'INTP': MbtiResult('Sang Pemikir', 'Penasaran dan gemar menganalisis ide. Suka memecahkan teka-teki logika dan menggali cara kerja segala hal.'),
  'ENTJ': MbtiResult('Sang Komandan', 'Pemimpin yang tegas dan berani mengambil keputusan. Terorganisasi, ambisius, dan pandai menggerakkan orang menuju tujuan.'),
  'ENTP': MbtiResult('Sang Pendebat', 'Cerdas dan penuh gagasan. Senang menantang pendapat, bertukar pikiran, dan mencoba hal-hal baru.'),
  'INFJ': MbtiResult('Sang Advokat', 'Tenang, penuh empati, dan berpegang pada nilai. Ingin memberi dampak baik bagi orang lain.'),
  'INFP': MbtiResult('Sang Mediator', 'Idealis dan imajinatif. Mencari makna dalam hidup serta setia pada nilai-nilai pribadinya.'),
  'ENFJ': MbtiResult('Sang Protagonis', 'Karismatik dan peduli. Pandai menginspirasi serta membantu orang lain berkembang.'),
  'ENFP': MbtiResult('Sang Juru Kampanye', 'Antusias, kreatif, dan mudah bergaul. Melihat peluang dan kemungkinan di mana-mana.'),
  'ISTJ': MbtiResult('Sang Ahli Logistik', 'Teliti, bertanggung jawab, dan dapat diandalkan. Menghargai aturan, fakta, dan komitmen.'),
  'ISFJ': MbtiResult('Sang Pelindung', 'Hangat, setia, dan perhatian. Selalu siap menjaga serta membantu orang-orang terdekat.'),
  'ESTJ': MbtiResult('Sang Eksekutif', 'Tegas dan teratur. Pandai mengelola orang dan proses agar semuanya berjalan sesuai aturan.'),
  'ESFJ': MbtiResult('Sang Konsul', 'Ramah, suportif, dan suka bekerja sama. Senang menciptakan suasana yang harmonis.'),
  'ISTP': MbtiResult('Sang Pengrajin', 'Tenang, praktis, dan suka mengutak-atik. Cepat tanggap saat harus memecahkan masalah nyata.'),
  'ISFP': MbtiResult('Sang Petualang', 'Lembut, artistik, dan fleksibel. Menikmati keindahan dan menjalani hidup sesuai kata hatinya.'),
  'ESTP': MbtiResult('Sang Pengusaha', 'Energik, berani, dan spontan. Suka bertindak cepat dan menikmati tantangan di saat ini.'),
  'ESFP': MbtiResult('Sang Penghibur', 'Spontan, ceria, dan mudah mencairkan suasana. Senang berbagi kegembiraan dengan orang lain.'),
};

// Pasangan huruf pada setiap dimensi.
const List<List<String>> _pairs = [
  ['E', 'I'],
  ['S', 'N'],
  ['T', 'F'],
  ['J', 'P'],
];

const Map<String, String> _opposite = {
  'E': 'I', 'I': 'E',
  'S': 'N', 'N': 'S',
  'T': 'F', 'F': 'T',
  'J': 'P', 'P': 'J',
};

const Map<String, String> _letterNames = {
  'E': 'Extrovert', 'I': 'Introvert',
  'S': 'Sensing', 'N': 'Intuition',
  'T': 'Thinking', 'F': 'Feeling',
  'J': 'Judging', 'P': 'Perceiving',
};

// Hasil perhitungan: tipe (contoh 'INFP') dan persentase huruf pertama
// dari tiap pasangan (E, S, T, J).
class _MbtiOutcome {
  const _MbtiOutcome(this.type, this.firstPercents);

  final String type;
  final List<double> firstPercents;
}

// Skor tiap jawaban: Sangat Setuju = +2 ... Sangat Tidak Setuju = -2.
// Jawaban setuju menambah poin huruf soal, tidak setuju menambah
// poin huruf lawannya. Jika skor seri, dipilih huruf kedua (I, N, F, P).
_MbtiOutcome _calculateOutcome(List<int?> answers) {
  final points = {for (final letter in _opposite.keys) letter: 0};

  for (int i = 0; i < mbtiQuestions.length; i++) {
    final answer = answers[i];
    if (answer == null) continue;

    final score = 2 - answer;
    final letter = mbtiQuestions[i].letter;
    final other = _opposite[letter]!;

    if (score > 0) points[letter] = points[letter]! + score;
    if (score < 0) points[other] = points[other]! - score;
  }

  var type = '';
  final percents = <double>[];

  for (final pair in _pairs) {
    final first = points[pair[0]]!;
    final second = points[pair[1]]!;
    final total = first + second;

    percents.add(total == 0 ? 0.5 : first / total);
    type += first > second ? pair[0] : pair[1];
  }

  return _MbtiOutcome(type, percents);
}

// =====================================================================
// BAGIAN 4 — HALAMAN TEST MBTI
// Mengatur alur: soal -> istirahat (tiap 20 soal) -> hasil.
// =====================================================================

enum _Phase { question, rest, result }

class TestMbtiPage extends StatefulWidget {
  const TestMbtiPage({super.key});

  @override
  State<TestMbtiPage> createState() => _TestMbtiPageState();
}

class _TestMbtiPageState extends State<TestMbtiPage> {
  // Jawaban setiap soal: 0 = Sangat Setuju ... 4 = Sangat Tidak Setuju.
  // null = belum dijawab.
  final List<int?> _answers = List<int?>.filled(mbtiQuestions.length, null);

  int _index = 0; // soal yang sedang tampil
  _Phase _phase = _Phase.question;
  _MbtiOutcome? _outcome;

  int get _total => mbtiQuestions.length;
  int get _answeredCount => _answers.where((a) => a != null).length;

  // Tombol kembali: beri konfirmasi jika sudah ada soal yang dijawab.
  Future<void> _handleBack() async {
    if (_phase == _Phase.result || _answeredCount == 0) {
      Navigator.of(context).pop();
      return;
    }

    final leave = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Keluar dari tes?',
          style: TextStyle(color: AppColors.dark),
        ),
        content: const Text(
          'Jawabanmu belum tersimpan dan akan hilang jika kamu kembali ke Home.',
          style: TextStyle(color: AppColors.dark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text(
              'Lanjutkan Tes',
              style: TextStyle(color: AppColors.green),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text(
              'Keluar',
              style: TextStyle(color: AppColors.orange),
            ),
          ),
        ],
      ),
    );

    if (leave == true && mounted) {
      Navigator.of(context).pop();
    }
  }

  void _selectAnswer(int optionIndex) {
    setState(() {
      _answers[_index] = optionIndex;
    });
  }

  void _handleNext() {
    // Soal harus dijawab dulu sebelum lanjut.
    if (_answers[_index] == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Pilih salah satu jawaban dulu ya.'),
            backgroundColor: AppColors.dark,
            duration: Duration(seconds: 1),
          ),
        );
      return;
    }

    setState(() {
      if (_index == _total - 1) {
        // Soal terakhir: hitung hasil.
        _outcome = _calculateOutcome(_answers);
        _phase = _Phase.result;
      } else if ((_index + 1) % MbtiConfig.restEvery == 0) {
        // Kelipatan restEvery: tampilkan jeda istirahat.
        _phase = _Phase.rest;
      } else {
        _index++;
      }
    });
  }

  void _handlePrevious() {
    if (_index == 0) return;
    setState(() {
      _index--;
    });
  }

  // Dari layar istirahat: lanjut ke soal berikutnya.
  void _continueAfterRest() {
    setState(() {
      _index++;
      _phase = _Phase.question;
    });
  }

  // Dari layar istirahat: kembali melihat soal sebelumnya.
  void _backFromRest() {
    setState(() {
      _phase = _Phase.question;
    });
  }

  void _restart() {
    setState(() {
      _answers.fillRange(0, _total, null);
      _index = 0;
      _outcome = null;
      _phase = _Phase.question;
    });
  }

  // Isi halaman sesuai tahap yang sedang berjalan.
  List<Widget> _buildBody() {
    switch (_phase) {
      case _Phase.question:
        return [
          _ProgressHeader(current: _index + 1, total: _total),
          const SizedBox(height: MbtiLayout.progressToCard),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _QuestionCard(
              key: ValueKey(_index),
              question: mbtiQuestions[_index].text,
              selected: _answers[_index],
              onSelect: _selectAnswer,
            ),
          ),
        ];

      case _Phase.rest:
        return [
          _RestCard(answered: _index + 1, total: _total),
        ];

      case _Phase.result:
        return [
          _ResultCard(outcome: _outcome!),
          const SizedBox(height: 16),
          _PillButton(
            label: 'Ulangi Tes',
            color: AppColors.green,
            onTap: _restart,
          ),
          const SizedBox(height: 10),
          _PillButton(
            label: 'Kembali ke Home',
            color: MbtiColors.answerIdle,
            onTap: () => Navigator.of(context).pop(),
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLastQuestion = _index == _total - 1;

    return PopScope(
      // Tombol kembali bawaan Android juga melewati konfirmasi.
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _handleBack();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final screenHeight = constraints.maxHeight;
              final showBar = _phase != _Phase.result;

              return SizedBox(
                width: screenWidth,
                height: screenHeight,
                child: Stack(
                  children: [
                    // 1. DEKORASI (kucing, tanaman, kupu-kupu, kilau)
                    Positioned.fill(
                      child: _Decorations(
                        width: screenWidth,
                        height: screenHeight,
                      ),
                    ),

                    // 2. KONTEN UTAMA
                    SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        MbtiLayout.topSpace,
                        0,
                        (showBar ? MbtiLayout.nextBarHeight : 0.0) +
                            MbtiLayout.bottomSpace +
                            24,
                      ),
                      child: Center(
                        child: SizedBox(
                          width: screenWidth * MbtiLayout.contentWidth,
                          child: Column(
                            children: [
                              _TopBar(
                                onBack: _handleBack,
                                onMenu: () {
                                  // TODO: Tentukan fungsi tombol kanan atas.
                                },
                              ),
                              const SizedBox(height: MbtiLayout.topToProgress),
                              ..._buildBody(),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // 3. TOMBOL NEXT DI BAWAH
                    if (showBar)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: MbtiLayout.bottomSpace,
                        child: Center(
                          child: SizedBox(
                            width: screenWidth * MbtiLayout.nextBarWidth,
                            child: _phase == _Phase.question
                                ? _NextBar(
                                    label: isLastQuestion
                                        ? MbtiConfig.finishLabel
                                        : MbtiConfig.nextLabel,
                                    enabled: _answers[_index] != null,
                                    onNext: _handleNext,
                                    onPrev: _index > 0 ? _handlePrevious : null,
                                  )
                                : _NextBar(
                                    label: MbtiConfig.restLabel,
                                    enabled: true,
                                    onNext: _continueAfterRest,
                                    onPrev: _backFromRest,
                                  ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// BAGIAN 5 — KOMPONEN BAGIAN ATAS
// Tombol kembali, tombol menu, dan progress soal.
// =====================================================================

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBack, required this.onMenu});

  final VoidCallback onBack;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _SquareButton(
          assetPath: MbtiAssets.iconBack,
          fallbackIcon: Icons.chevron_left,
          onTap: onBack,
        ),
        _SquareButton(
          assetPath: MbtiAssets.iconMenu,
          fallbackIcon: Icons.sort,
          onTap: onMenu,
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
          size: 24,
          color: AppColors.cream,
        ),
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('《 $current / $total 》', style: MbtiText.counter),
        const SizedBox(height: 6),
        Row(
          children: [
            // Daun kiri
            const AssetOrIcon(
              assetPath: MbtiAssets.progressLeaf,
              fallbackIcon: Icons.eco,
              size: MbtiLayout.progressLeafSize,
            ),
            const SizedBox(width: 4),

            // Progress bar
            Expanded(child: _ProgressBar(value: current / total)),
            const SizedBox(width: 4),

            // Daun kanan (daun kiri yang dicerminkan)
            Transform.flip(
              flipX: true,
              child: const AssetOrIcon(
                assetPath: MbtiAssets.progressLeaf,
                fallbackIcon: Icons.eco,
                size: MbtiLayout.progressLeafSize,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value});

  final double value; // 0.0 sampai 1.0

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const radius = BorderRadius.all(Radius.circular(10));

        return SizedBox(
          height: MbtiLayout.progressHeight,
          child: Stack(
            children: [
              // Latar
              Container(
                decoration: const BoxDecoration(
                  color: MbtiColors.progressTrack,
                  borderRadius: radius,
                ),
              ),

              // Isi (bertambah dengan animasi)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: constraints.maxWidth * value.clamp(0.0, 1.0),
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  borderRadius: radius,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// =====================================================================
// BAGIAN 6 — KARTU SOAL, ISTIRAHAT, DAN HASIL
// Ketiganya memakai bentuk kartu cokelat yang sama (_CardShell).
// =====================================================================

// Bentuk kartu: sudut atas membulat, bagian bawah melengkung.
class _CardClipper extends CustomClipper<Path> {
  const _CardClipper();

  @override
  Path getClip(Size size) {
    const r = MbtiLayout.cardRadius;
    const d = MbtiLayout.cardCurveDepth;

    return Path()
      ..moveTo(0, r)
      ..arcToPoint(const Offset(r, 0), radius: const Radius.circular(r))
      ..lineTo(size.width - r, 0)
      ..arcToPoint(Offset(size.width, r), radius: const Radius.circular(r))
      ..lineTo(size.width, size.height - d)
      ..quadraticBezierTo(size.width / 2, size.height + d, 0, size.height - d)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _CardShell extends StatelessWidget {
  const _CardShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const _CardClipper(),
      child: Container(
        width: double.infinity,
        color: AppColors.dark,
        child: Stack(
          children: [
            // Isi kartu
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                36,
                20,
                MbtiLayout.cardCurveDepth + 28,
              ),
              child: child,
            ),

            // Bulatan kecil di kiri atas
            const Positioned(
              left: 14,
              top: 14,
              child: SizedBox(
                width: MbtiLayout.cardDotSize,
                height: MbtiLayout.cardDotSize,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.cream,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

            // Daun kecil di kiri bawah
            const Positioned(
              left: 24,
              bottom: MbtiLayout.cardCurveDepth * 0.7,
              child: AssetOrIcon(
                assetPath: MbtiAssets.cardLeaf,
                fallbackIcon: Icons.eco,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Kartu soal + 5 pilihan jawaban
// ---------------------------------------------------------------------
class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    super.key,
    required this.question,
    required this.selected,
    required this.onSelect,
  });

  final String question;
  final int? selected; // indeks jawaban terpilih
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        children: [
          Text(
            question,
            textAlign: TextAlign.center,
            style: MbtiText.question,
          ),
          const SizedBox(height: 22),
          for (int i = 0; i < MbtiConfig.answerLabels.length; i++) ...[
            _AnswerOption(
              label: MbtiConfig.answerLabels[i],
              selected: selected == i,
              onTap: () => onSelect(i),
            ),
            if (i != MbtiConfig.answerLabels.length - 1)
              const SizedBox(height: MbtiLayout.answerGap),
          ],
        ],
      ),
    );
  }
}

class _AnswerOption extends StatelessWidget {
  const _AnswerOption({
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
          color: selected ? AppColors.green : MbtiColors.answerIdle,
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
                style: MbtiText.answer,
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

// ---------------------------------------------------------------------
// Kartu istirahat (muncul setiap MbtiConfig.restEvery soal)
// ---------------------------------------------------------------------
class _RestCard extends StatelessWidget {
  const _RestCard({required this.answered, required this.total});

  final int answered;
  final int total;

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        children: [
          const Text('Waktunya Istirahat', style: MbtiText.heading),
          const SizedBox(height: 12),
          Text(
            'Kamu sudah menjawab $answered dari $total soal. '
            'Tarik napas dalam-dalam, minum seteguk air, '
            'lalu lanjut kalau sudah siap.',
            textAlign: TextAlign.center,
            style: MbtiText.question,
          ),
          const SizedBox(height: 28),
          const _BreathingCircle(),
          const SizedBox(height: 16),
          const Text(
            'Tarik napas ... hembuskan ...',
            style: MbtiText.answer,
          ),
        ],
      ),
    );
  }
}

// Lingkaran yang membesar-mengecil sebagai panduan bernapas.
class _BreathingCircle extends StatefulWidget {
  const _BreathingCircle();

  @override
  State<_BreathingCircle> createState() => _BreathingCircleState();
}

class _BreathingCircleState extends State<_BreathingCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.6, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      ),
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          color: AppColors.green,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.cream, width: 3),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Kartu hasil
// ---------------------------------------------------------------------
class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.outcome});

  final _MbtiOutcome outcome;

  @override
  Widget build(BuildContext context) {
    final result = mbtiResults[outcome.type];

    return _CardShell(
      child: Column(
        children: [
          const Text('Hasil Tesmu', style: MbtiText.answer),
          const SizedBox(height: 8),
          Text(outcome.type, style: MbtiText.bigCode),
          Text(
            result?.title ?? '',
            style: MbtiText.heading.copyWith(color: AppColors.orange),
          ),
          const SizedBox(height: 14),
          Text(
            result?.description ?? '',
            textAlign: TextAlign.center,
            style: MbtiText.question,
          ),
          const SizedBox(height: 22),
          for (int i = 0; i < _pairs.length; i++) ...[
            _PairBar(
              first: _pairs[i][0],
              second: _pairs[i][1],
              firstPercent: outcome.firstPercents[i],
            ),
            if (i != _pairs.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

// Bar persentase untuk satu pasangan huruf (contoh Extrovert vs Introvert).
class _PairBar extends StatelessWidget {
  const _PairBar({
    required this.first,
    required this.second,
    required this.firstPercent,
  });

  final String first;
  final String second;
  final double firstPercent; // 0.0 sampai 1.0

  @override
  Widget build(BuildContext context) {
    final firstPct = (firstPercent * 100).round();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${_letterNames[first]} $firstPct%', style: MbtiText.answer),
            Text('${100 - firstPct}% ${_letterNames[second]}', style: MbtiText.answer),
          ],
        ),
        const SizedBox(height: 4),
        LayoutBuilder(
          builder: (context, constraints) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 10,
                child: Stack(
                  children: [
                    Container(color: MbtiColors.answerIdle),
                    Container(
                      width: constraints.maxWidth * firstPercent,
                      color: AppColors.green,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

// Tombol pil sederhana (dipakai di halaman hasil).
class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(label, style: MbtiText.heading),
      ),
    );
  }
}

// =====================================================================
// BAGIAN 7 — TOMBOL NEXT DAN DEKORASI
// =====================================================================

// Tombol hijau di bawah: panah kiri = soal sebelumnya,
// teks tengah dan panah kanan = lanjut.
class _NextBar extends StatelessWidget {
  const _NextBar({
    required this.label,
    required this.enabled,
    required this.onNext,
    required this.onPrev, // null = panah kiri nonaktif
  });

  final String label;
  final bool enabled;
  final VoidCallback onNext;
  final VoidCallback? onPrev;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: MbtiLayout.nextBarHeight,
      decoration: BoxDecoration(
        color: enabled ? AppColors.green : MbtiColors.nextDisabled,
        borderRadius: BorderRadius.circular(MbtiLayout.nextBarHeight / 2),
      ),
      child: Row(
        children: [
          _BarArrow(
            assetPath: MbtiAssets.arrowPrev,
            fallbackIcon: Icons.arrow_left,
            onTap: onPrev,
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onNext,
              child: Center(
                child: Text(label, style: MbtiText.nextLabel),
              ),
            ),
          ),
          _BarArrow(
            assetPath: MbtiAssets.arrowNext,
            fallbackIcon: Icons.arrow_right,
            onTap: onNext,
          ),
        ],
      ),
    );
  }
}

class _BarArrow extends StatelessWidget {
  const _BarArrow({
    required this.assetPath,
    required this.fallbackIcon,
    required this.onTap,
  });

  final String assetPath;
  final IconData fallbackIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 64,
        height: double.infinity,
        child: Center(
          child: Opacity(
            opacity: onTap == null ? 0.35 : 1,
            child: AssetOrIcon(
              assetPath: assetPath,
              fallbackIcon: fallbackIcon,
              size: 40,
              color: AppColors.cream,
            ),
          ),
        ),
      ),
    );
  }
}

// Dekorasi di belakang konten. Tidak menerima sentuhan.
class _Decorations extends StatelessWidget {
  const _Decorations({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          // Tanaman kiri bawah
          Positioned(
            left: -width * 0.04,
            bottom: 0,
            child: AssetOrIcon(
              assetPath: MbtiAssets.plantLeft,
              fallbackIcon: Icons.eco,
              size: width * MbtiLayout.plantLeftSize,
            ),
          ),

          // Tanaman kanan bawah
          Positioned(
            right: 0,
            bottom: 0,
            child: AssetOrIcon(
              assetPath: MbtiAssets.plantRight,
              fallbackIcon: Icons.eco,
              size: width * MbtiLayout.plantRightSize,
            ),
          ),

          // Kucing
          Positioned(
            right: width * MbtiLayout.catRight,
            bottom: 0,
            child: AssetOrIcon(
              assetPath: MbtiAssets.cat,
              fallbackIcon: Icons.pets,
              size: width * MbtiLayout.catSize,
            ),
          ),

          // Kupu-kupu
          Positioned(
            right: width * MbtiLayout.butterflyRight,
            bottom: height * MbtiLayout.butterflyBottom,
            child: AssetOrIcon(
              assetPath: MbtiAssets.butterfly,
              fallbackIcon: Icons.flutter_dash,
              size: width * MbtiLayout.butterflySize,
            ),
          ),

          // Kilau-kilau
          for (final spot in MbtiLayout.sparkles)
            Positioned(
              right: width * spot.right,
              bottom: height * spot.bottom,
              child: AssetOrIcon(
                assetPath: MbtiAssets.sparkle,
                fallbackIcon: Icons.auto_awesome,
                size: width * spot.size,
              ),
            ),
        ],
      ),
    );
  }
}
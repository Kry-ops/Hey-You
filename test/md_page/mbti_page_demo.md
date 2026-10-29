// test_mbti_page.dart
import 'package:flutter/material.dart';

import '../core/app_colors.dart';

import '../model/mbti_data.dart';
import '../utils/mbti_layout.dart';
import '../widgets/mbti_widgets/curtain_reveal.dart';
import '../widgets/mbti_widgets/mbti_cards.dart';
import '../widgets/mbti_widgets/mbti_decorations.dart';
import '../widgets/mbti_widgets/mbti_next_bar.dart';
import '../widgets/mbti_widgets/mbti_progress.dart';
import '../widgets/mbti_widgets/mbti_top_bar.dart';


enum _Phase { intro, question, rest, result }

class TestMbtiPage extends StatefulWidget {
  const TestMbtiPage({super.key});
  @override
  State<TestMbtiPage> createState() => _TestMbtiPageState();
}

class _TestMbtiPageState extends State<TestMbtiPage> {
  // Jawaban setiap soal: 0 = Sangat Setuju ... 4 = Sangat Tidak Setuju.
  // null = belum dijawab.
  final List<int?> _answers = List<int?>.filled(mbtiQuestions.length, null);
  int _index = 0; // soal yang sedang tampil*
  _Phase _phase = _Phase.intro;
  MbtiOutcome? _outcome;
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
          'Keluar dari test?',
          style: TextStyle(color: AppColors.dark),
        ),
        content: const Text(
          'Jawaban yang sudah dijawab akan hilang kalau keluar sekarang NYET!!! (¬_¬ )',
          style: TextStyle(color: AppColors.dark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text(
              'Lanjutkan',
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

  // Dari kartu awal: mulai tes.
  void _startTest() {
    setState(() {
      _index = 0;
      _phase = _Phase.question;
    });
  }

  void _handleNext() {
    if (_answers[_index] == null) {
      showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          backgroundColor: AppColors.cream,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),

          // Judul pop-up.
          title: const Text(
            '(¬_¬")',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.dark,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          // Pesan peringatan.
          content: const Text(
            'Pilih jawaban dulu nyet, baru bisa lanjut!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.dark,
              fontSize: 15,
            ),
          ),

          // Tombol untuk menutup pop-up.
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.dark,
                foregroundColor: AppColors.cream,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 10,
                ),
              ),
              child: const Text('Dah sana lanjut'),
            ),
          ],
        ),
      );

      return;
    }
    setState(() {
      if (_index == _total - 1) {
        // Soal terakhir: hitung hasil.
        _outcome = calculateOutcome(_answers);
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
      _phase = _Phase.intro;
    });
  }

 
  List<Widget> _buildBody() {
    switch (_phase) {
      case _Phase.intro:
        return [
          const CurtainReveal(
            key: ValueKey('intro-curtain'),
            child: IntroCard(),
          ),
        ];
 
      case _Phase.question:
        return [
          ProgressHeader(current: _index + 1, total: _total),
          const SizedBox(height: MbtiLayout.progressToCard),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: QuestionCard(
              key: ValueKey(_index),
              question: mbtiQuestions[_index].text,
              selected: _answers[_index],
              onSelect: _selectAnswer,
            ),
          ),
        ];
 
      case _Phase.rest:
        return [
          // Progress bar tetap muncul pada papan jeda.
          ProgressHeader(
            current: _index + 1,
            total: _total,
          ),
          const SizedBox(height: MbtiLayout.progressToCard),
          RestCard(
            answered: _index + 1,
            total: _total,
          ),
        ];
 
      case _Phase.result:
        return [
          // Tidak ada progress bar pada halaman hasil.
          CurtainReveal(
            key: const ValueKey('result-curtain'),
            child: ResultCard(outcome: _outcome!),
          ),
          const SizedBox(height: 16),
          PillButton(
            label: 'Ulangi Tes',
            color: AppColors.green,
            onTap: _restart,
          ),
          const SizedBox(height: 10),
          PillButton(
            label: 'Kembali ke Home',
            color: AppColors.answerIdle,
            onTap: () => Navigator.of(context).pop(),
          ),
        ];
    }
  }

    // Tombol hijau di bawah, isinya mengikuti tahap yang sedang berjalan.
  Widget _buildBottomBar() {
    switch (_phase) {
      case _Phase.intro:
        return NextBar(
          label: MbtiConfig.startLabel,
          enabled: true,
          onNext: _startTest,
          onPrev: null,
        );

      case _Phase.question:
        return NextBar(
          label: _index == _total - 1
              ? MbtiConfig.finishLabel
              : MbtiConfig.nextLabel,
          enabled: _answers[_index] != null,
          onNext: _handleNext,
          onPrev: _index > 0 ? _handlePrevious : null,
        );

      case _Phase.rest:
        return NextBar(
          label: MbtiConfig.restLabel,
          enabled: true,
          onNext: _continueAfterRest,
          onPrev: _backFromRest,
        );

      case _Phase.result:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      child: Decorations(
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
                              TopBar(
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
                            child: _buildBottomBar(),
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


// mbti_layout.dart
import '../core/app_text.dart';


// Posisi satu dekorasi: right dan size dihitung dari LEBAR layar,
// bottom dihitung dari TINGGI layar (nilai 0.0 sampai 1.0).

class MbtiConfig {
  // Jeda istirahat muncul setiap sekian soal.
  static const int restEvery = 20;
  // Pilihan jawaban, urut dari yang paling setuju.
  static const List<String> answerLabels = [
    'Sangat Menggambarkan Dirimu',
    'Cukup Menggambarkan Dirimu',
    'Di Antara Keduanya',
    'Kurang Menggambarkan Dirimu',
    'Tidak Menggambarkan Dirimu',
  ];
  // Tulisan pada tombol bawah.
  static const String nextLabel = 'NEXT';
  static const String finishLabel = 'SELESAI'; // dipakai di soal terakhir*
  static const String restLabel = 'LANJUT'; // dipakai di layar istirahat*

  static const String startLabel = 'MULAI'; // tombol bawah di kartu awal

  // Teks kartu awal.
  static const String introTitle = 'Test MBTI';
  static const String introDescription =
      'Test mbti ini adalah hasil buatan manusia yang bukan seorang psikolog melainkan seorang software engineer.' ' Jadi jangan jadikan hasilnya sebagai patokan karena saya ga mau tanggung jawab.' ;

  // Lama animasi tirai jatuh (kartu awal dan kartu hasil).
  static const Duration curtainDuration = Duration(milliseconds: 1400);
}

class DecoSpot {
  const DecoSpot(this.right, this.bottom, this.size);
  final double right;
  final double bottom;
  final double size;
}

class MbtiLayout {

  // LEBAR & JARAK
  static const double contentWidth = 0.90; // lebar konten*
  static const double topSpace = 42; // jarak tombol atas dari atas layar*
  static const double topToProgress = 16; // tombol atas ke progress*
  static const double progressToCard = 14; // progress ke kartu soal*
  static const double bottomSpace = 12; // jarak tombol NEXT dari bawah*

  // KOMPONEN
  // UKURAN DUA TOMBOL DI BAGIAN ATAS.
  // Ubah angka ini kalau 30 px terasa terlalu kecil atau terlalu besar.
  static const double topButtonSize = 30;
  static const double topButtonIconSize = 15; // ukuran ikon di dalam tombol*
  static const double topButtonRadius = 10;
  static const double progressHeight = 6;
  static const double progressLeafSize = 28;
  static const double cardRadius = 42; // lengkung sudut atas kartu*
  static const double cardCurveDepth = 46; // lengkung bawah kartu*
  static const double cardDotSize = 28; // bulatan kecil di kiri atas kartu*
  static const double answerHeight = 45;
  static const double answerGap = 10;
  static const double nextBarHeight = 56;
  static const double nextBarWidth = 0.90;

  // DEKORASI (kucing, tanaman, kupu-kupu, kilau)
  static const double catSize = 0.85;
  static const double catRight = -0.17;
  static const double plantLeftSize = 0.40;
  static const double plantRightSize = 0.28;
  static const double butterflySize = 0.10;
  static const double butterflyRight = 0.40;
  static const double butterflyBottom = 0.16;
  static const List<DecoSpot> sparkles = [
    DecoSpot(0.40, 0.27, 0.05),
    DecoSpot(0.43, 0.235, 0.03),
    DecoSpot(0.34, 0.19, 0.04),
    DecoSpot(0.37, 0.39, 0.04),
  ];

  // UKURAN KARTU SOAL
  // Tinggi kartu dihitung dari nilai-nilai di bawah, jadi selalu sama
  // untuk semua soal, entah teksnya pendek atau panjang.
  static const double cardPaddingTop = 30; // tepi atas kartu ke area soal*
  static const double cardPaddingSide = 25; // tepi kiri-kanan kartu*
  static const double cardPaddingBottom = cardCurveDepth + 14; // ruang bawah*
  static const double questionToAnswers = 25; // area soal ke jawaban pertama*
  static const int questionLines = 3; // area soal setinggi sekian baris*
  // Tinggi area soal = jumlah baris x tinggi satu baris teks.
  static double get questionAreaHeight =>
      questionLines *
      (AppText.question.fontSize! * AppText.question.height!);
  // Tinggi total kartu soal.
  static double get cardHeight {
    final count = MbtiConfig.answerLabels.length;
    final answers = count * answerHeight + (count - 1) * answerGap;
    return cardPaddingTop +
        questionAreaHeight +
        questionToAnswers +
        answers +
        cardPaddingBottom;
  }

  static const double curtainRollerHeight = 18; // tebal gulungan tirai
  static const double curtainRollerOverhang = 6; // gulungan lebih lebar dari kartu

  // TOMBOL MENU BAGIAN ATAS
  // Lebar minimum dan maksimum dropdown.
  static const double menuMinWidth = 230;
  static const double menuMaxWidth = 265;

  // Jarak vertikal isi dropdown dari tepinya.
  static const double menuVerticalPadding = 3;
  // Jarak horizontal isi menu dari tepi dropdown.
  static const double menuHorizontalPadding = 12;
  // Tinggi setiap pilihan menu.
  static const double menuItemHeight = 42;
  // Radius sudut dropdown.
  static const double menuRadius = 10;
  // Tinggi elevasi atau bayangan dropdown.
  static const double menuElevation = 8;

  // IKON DI DALAM DROPDOWN
  // Ukuran ikon Petunjuk Tes dan Hai NYET.
  static const double menuIconSize = 22;
  // Jarak ikon ke tulisan.
  static const double menuIconTextGap = 20;
  // Ukuran tulisan menu.
  static const double menuTextSize = 14;

  // DIALOG PETUNJUK DAN SAPAAN
  // Radius sudut dialog.
  static const double dialogRadius = 22;
  // Ukuran judul dialog Petunjuk Tes.
  static const double helpTitleSize = 18;
  // Ukuran isi dialog.
  static const double dialogContentSize = 13;
  // Ukuran teks dialog sapaan.
  static const double greetingTextSize = 16;
  // Jarak padding horizontal dialog.
  static const double dialogHorizontalPadding = 24;
  // Jarak padding vertikal dialog.
  static const double dialogVerticalPadding = 20;
  // Ukuran teks tombol Mengerti.
  static const double dialogButtonTextSize = 14;
}

// curtain_reveal.dart
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../utils/mbti_layout.dart';

// Animasi tirai jatuh: isi dibuka dari atas ke bawah, dan gulungan
// mengikuti ujung bawahnya. Animasi jalan sekali saat widget muncul.
// Tinggi isi tidak perlu diketahui, jadi cocok untuk kartu hasil.
class CurtainReveal extends StatefulWidget {
  const CurtainReveal({super.key, required this.child});

  final Widget child;

  @override
  State<CurtainReveal> createState() => _CurtainRevealState();
}

class _CurtainRevealState extends State<CurtainReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: MbtiConfig.curtainDuration,
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        // 0.0 = tirai tertutup, 1.0 = terbuka penuh.
        final progress = Curves.easeInOutCubic.transform(_controller.value);

        // Gulungan memudar di akhir animasi.
        final rollerOpacity =
            (1 - ((progress - 0.88) / 0.12).clamp(0.0, 1.0)).toDouble();

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Isi: hanya bagian atas setinggi `progress` yang terlihat.
            ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: progress,
                child: child,
              ),
            ),

            // Gulungan di ujung bawah bagian yang terlihat.
            if (rollerOpacity > 0)
              Positioned(
                left: -MbtiLayout.curtainRollerOverhang,
                right: -MbtiLayout.curtainRollerOverhang,
                bottom: -MbtiLayout.curtainRollerHeight / 2,
                child: Opacity(
                  opacity: rollerOpacity,
                  child: Container(
                    height: MbtiLayout.curtainRollerHeight,
                    decoration: BoxDecoration(
                      color: AppColors.curtainRoller,
                      borderRadius: BorderRadius.circular(
                        MbtiLayout.curtainRollerHeight / 2,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

// Mengecilkan isi otomatis jika lebih besar dari area yang tersedia,
// sehingga tidak overflow (dipakai kartu awal).
class ScaleToFit extends StatelessWidget {
  const ScaleToFit({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: constraints.maxWidth),
            child: child,
          ),
        );
      },
    );
  }
}


// mbti_answer_option.dart
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text.dart';
import '../../core/app_assets.dart';
import '../../utils/mbti_layout.dart';
import '../asset_or_icon.dart';

// KOMPONEN PILIHAN JAWABAN MBTI
// Menampilkan pilihan jawaban dengan ikon centang kustom.
class AnswerOption extends StatelessWidget {
  const AnswerOption({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Ukuran bulatan krem di sebelah kiri.
    const circleSize = MbtiLayout.answerHeight - 12;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: MbtiLayout.answerHeight,
        padding: const EdgeInsets.symmetric(horizontal: 6),

        // Warna berubah sesuai kondisi pilihan.
        decoration: BoxDecoration(
          color: selected ? AppColors.green : AppColors.answerIdle,
          borderRadius: BorderRadius.circular(
            MbtiLayout.answerHeight / 2,
          ),
        ),

        child: Row(
          children: [
            // Bulatan krem berisi ikon centang ketika dipilih.
            Container(
              width: circleSize,
              height: circleSize,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.cream,
                shape: BoxShape.circle,
              ),

              // Ikon hanya muncul jika jawaban dipilih.
              child: selected
                  ? const AssetOrIcon(
                      assetPath: AppAssets.iconCheck,
                      fallbackIcon: Icons.check_rounded,
                      size: 18,
                      color: AppColors.green,
                    )
                  : null,
            ),

            const SizedBox(width: 12),

            // Teks jawaban.
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


// mbti_cards.dart
import 'package:flutter/material.dart';
import 'dart:async';

import '../../core/app_colors.dart';
import '../../core/app_text.dart';
import '../../core/app_assets.dart';
import '../../widgets/asset_or_icon.dart';

import '../../model/mbti_data.dart';
import '../../utils/mbti_layout.dart';
import '../../widgets/mbti_widgets/curtain_reveal.dart';
import '../../widgets/mbti_widgets/mbti_answer_option.dart';

// BAGIAN 6 — KARTU SOAL, ISTIRAHAT, DAN HASIL
// Ketiganya memakai bentuk kartu cokelat yang sama (_CardShell).
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

// 2) class _CardShell (Bagian 6)
//    GANTI seluruh class-nya dengan ini.
//    Tanpa `height`, tinggi kartu mengikuti isi (dipakai kartu hasil).

class _CardShell extends StatelessWidget {
  const _CardShell({required this.child, this.height});
  final Widget child;
  final double? height; // null = tinggi mengikuti isi*
  @override
  Widget build(BuildContext context) {
    // Jika tinggi ditentukan, isi diletakkan di tengah area kartu.
    final content = height == null
        ? child
        : SizedBox(
            width: double.infinity,
            height:
                height! -
                MbtiLayout.cardPaddingTop -
                MbtiLayout.cardPaddingBottom,
            child: Center(child: child),
          );
    return ClipPath(
      clipper: const _CardClipper(),
      child: Container(
        width: double.infinity,
        height: height,
        color: AppColors.dark,
        child: Stack(
          children: [
            // Isi kartu
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MbtiLayout.cardPaddingSide,
                MbtiLayout.cardPaddingTop,
                MbtiLayout.cardPaddingSide,
                MbtiLayout.cardPaddingBottom,
              ),
              child: content,
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
                assetPath: AppAssets.cardLeaf,
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

// Kartu awal sebelum tes dimulai. Tingginya sama dengan kartu soal.
class IntroCard extends StatelessWidget {
  const IntroCard();

  @override
  Widget build(BuildContext context) {
    final notes = ['Just for fun pren ＞︿＜', 'Akan ada 60 soal BTW'];

    return _CardShell(
      height: MbtiLayout.cardHeight,
      child: ScaleToFit(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              MbtiConfig.introTitle,
              style: AppText.heading.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 14),
            Text(
              MbtiConfig.introDescription,
              textAlign: TextAlign.center,
              style: AppText.question,
            ),
            const SizedBox(height: 20),
            for (final note in notes)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  '•  $note',
                  textAlign: TextAlign.center,
                  style: AppText.answer,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Kartu soal + 5 pilihan jawaban

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    super.key,
    required this.question,
    required this.selected,
    required this.onSelect,
  });
  final String question;
  final int? selected; // indeks jawaban terpilih*
  final ValueChanged<int> onSelect;
  @override
  State<QuestionCard> createState() => QuestionCardState();
}

class QuestionCardState extends State<QuestionCard> {
  int _visibleCharacters = 0;
  Timer? _typingTimer;
  // Ubah nilai ini untuk mengatur kecepatan mengetik (semakin kecil semakin cepat).
  static const Duration _typingSpeed = Duration(milliseconds: 32);
  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _typingTimer?.cancel();
    _visibleCharacters = 0;
    _typingTimer = Timer.periodic(_typingSpeed, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_visibleCharacters >= widget.question.length) {
        timer.cancel();
        return;
      }
      setState(() => _visibleCharacters++);
    });
  }

  @override
  void didUpdateWidget(covariant QuestionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) _startTyping();
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.question;
    final selected = widget.selected;
    final onSelect = widget.onSelect;
    return _CardShell(
      height: MbtiLayout.cardHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Area soal (tinggi tetap, teks di tengah)
          SizedBox(
            height: MbtiLayout.questionAreaHeight,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                    // Huruf pertanyaan muncul satu per satu seperti sedang diketik.
                    child: Text(
                      question.substring(
                        0,
                        _visibleCharacters.clamp(0, question.length).toInt(),
                      ),
                      textAlign: TextAlign.center,
                      style: AppText.question,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: MbtiLayout.questionToAnswers),
          // Pilihan jawaban
          for (int i = 0; i < MbtiConfig.answerLabels.length; i++) ...[
            AnswerOption(
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

// Kartu istirahat (muncul setiap MbtiConfig.restEvery soal)

class RestCard extends StatelessWidget {
  const RestCard({required this.answered, required this.total});
  final int answered;
  final int total;
  @override
  Widget build(BuildContext context) {
    return _CardShell(
      height: MbtiLayout.cardHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Jeda Pikiran Bentar ＼(ﾟｰﾟ＼)', style: AppText.heading),
          const SizedBox(height: 12),
          Text(
            '$answered soal dari $total soal. '
            'udah dijawab.'
            'Lu keren banget bisa jawab.',
            textAlign: TextAlign.center,
            style: AppText.question,
          ),
          const SizedBox(height: 28),
          const _BreathingCircle(),
          const SizedBox(height: 16),
          const Text(
            'Kalau udah siap, tekan lanjut pren',
            style: AppText.answer,
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
      scale: Tween<double>(
        begin: 0.6,
        end: 1.0,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
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
// Kartu hasil

class ResultCard extends StatelessWidget {
  const ResultCard({required this.outcome});
  final MbtiOutcome outcome;
  @override
  Widget build(BuildContext context) {
    final result = mbtiResults[outcome.type];
    return _CardShell(
      child: Column(
        children: [
          const Text('Ini Hasil Tes Kamu BTW', style: AppText.answer),
          const SizedBox(height: 8),
          Text(outcome.type, style: AppText.bigCode),
          Text(
            result?.title ?? '',
            style: AppText.heading.copyWith(color: AppColors.orange),
          ),
          const SizedBox(height: 14),
          Text(
            result?.description ?? '',
            textAlign: TextAlign.center,
            style: AppText.question,
          ),
          const SizedBox(height: 22),
          for (int i = 0; i < pairs.length; i++) ...[
            _PairBar(
              first: pairs[i][0],
              second: pairs[i][1],
              firstPercent: outcome.firstPercents[i],
            ),
            if (i != pairs.length - 1) const SizedBox(height: 12),
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
  final double firstPercent; // 0.0 sampai 1.0*
  @override
  Widget build(BuildContext context) {
    final firstPct = (firstPercent * 100).round();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${letterNames[first]} $firstPct%', style: AppText.answer),
            Text(
              '${100 - firstPct}% ${letterNames[second]}',
              style: AppText.answer,
            ),
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
                    Container(color: AppColors.answerIdle),
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

// mbti_decoration.dart
import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../widgets/asset_or_icon.dart';

import '../../utils/mbti_layout.dart';

// Dekorasi di belakang konten. Tidak menerima sentuhan.
class Decorations extends StatelessWidget {
  const Decorations({required this.width, required this.height});
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
              assetPath: AppAssets.plantLeft,
              fallbackIcon: Icons.eco,
              size: width * MbtiLayout.plantLeftSize,
            ),
          ),
          // Tanaman kanan bawah
          Positioned(
            right: 0,
            bottom: 0,
            child: AssetOrIcon(
              assetPath: AppAssets.plantRight,
              fallbackIcon: Icons.eco,
              size: width * MbtiLayout.plantRightSize,
            ),
          ),
          // Kucing
          Positioned(
            right: width * MbtiLayout.catRight,
            bottom: 0,
            child: AssetOrIcon(
              assetPath: AppAssets.cat,
              fallbackIcon: Icons.pets,
              size: width * MbtiLayout.catSize,
            ),
          ),
          // Kupu-kupu
          Positioned(
            right: width * MbtiLayout.butterflyRight,
            bottom: height * MbtiLayout.butterflyBottom,
            child: AssetOrIcon(
              assetPath: AppAssets.butterfly,
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
                assetPath: AppAssets.sparkle,
                fallbackIcon: Icons.auto_awesome,
                size: width * spot.size,
              ),
            ),
        ],
      ),
    );
  }
}

// mbti_next_bar.dart
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text.dart';
import '../../core/app_assets.dart';
import '../../widgets/asset_or_icon.dart';
import '../../utils/mbti_layout.dart';

// BAGIAN 7 — TOMBOL NEXT DAN DEKORASI
// Tombol hijau di bawah: panah kiri = soal sebelumnya,
// teks tengah dan panah kanan = lanjut.
class NextBar extends StatelessWidget {
  const NextBar({
    required this.label,
    required this.enabled,
    required this.onNext,
    required this.onPrev, // null = panah kiri nonaktif*
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
        color: enabled ? AppColors.green : AppColors.nextDisabled,
        borderRadius: BorderRadius.circular(MbtiLayout.nextBarHeight / 2),
      ),
      child: Row(
        children: [
          _BarArrow(
            assetPath: AppAssets.arrowPrev,
            fallbackIcon: Icons.arrow_left,
            onTap: onPrev,
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onNext,
              child: Center(
                child: Text(label, style: AppText.nextLabel),
              ),
            ),
          ),
          _BarArrow(
            assetPath: AppAssets.arrowNext,
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

// Tombol pil sederhana (dipakai di halaman hasil).

class PillButton extends StatelessWidget {
  const PillButton({
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
        child: Text(label, style: AppText.heading),
      ),
    );
  }
}

// mbti_progress.dart
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_text.dart';
import '../../core/app_assets.dart';
import '../../widgets/asset_or_icon.dart';

import '../../utils/mbti_layout.dart';

// progress di atas card
class ProgressHeader extends StatelessWidget {
  const ProgressHeader({required this.current, required this.total});
  final int current;
  final int total;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$current / $total', style: AppText.counter),
        const SizedBox(height: 6),
        Row(
          children: [
            // Daun kiri
            const AssetOrIcon(
              assetPath: AppAssets.progressLeaf,
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
                assetPath: AppAssets.progressLeaf,
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
  final double value; // 0.0 sampai 1.0*
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
                  color: AppColors.progressTrack,
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

// mbti_top_bar.dart
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
                    'Petunjuk',
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
                    'Nyari apa sih, ga ada apa apa disini （￣︶￣）',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.dark,
                      fontSize: 16,
                    ),
                  ),
                  // actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      child: const Text(
                        'Dah sana lanjut',
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
              // padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  AssetOrIcon(
                    assetPath: AppAssets.iconPetunjuk,
                    fallbackIcon: Icons.help_outline_rounded,
                    size: MbtiLayout.menuIconSize,
                    color: AppColors.dark,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Petunjuk',
                    style: TextStyle(
                      fontSize: MbtiLayout.menuTextSize,
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
              // padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  AssetOrIcon(
                    assetPath: AppAssets.iconHaiNyet,
                    fallbackIcon: Icons.favorite_border_rounded,
                    size: MbtiLayout.menuIconSize,
                    color: AppColors.dark,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Hai NYET 🫶',
                    style: TextStyle(
                      fontSize: MbtiLayout.menuTextSize,
                      color: AppColors.dark,
                    ),
                  ),
                ],
              ),
            ),


            const PopupMenuItem<String>(
              value: 'music',
              height: 42,
              // padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  AssetOrIcon(
                    assetPath: AppAssets.iconMusicMBTI,
                    fallbackIcon: Icons.library_music_rounded,
                    size: MbtiLayout.menuIconSize,
                    color: AppColors.dark,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Backsound Music',
                    style: TextStyle(
                      fontSize: MbtiLayout.menuTextSize,
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
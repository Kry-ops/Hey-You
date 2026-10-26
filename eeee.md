// =====================================================================
// UPDATE: KARTU AWAL + ANIMASI TIRAI (untuk kartu awal dan kartu hasil)
// Ada 7 langkah. Kerjakan berurutan; yang tidak disebut tidak berubah.
// =====================================================================


// ---------------------------------------------------------------------
// LANGKAH 1 — class MbtiColors (Bagian 1)
// Tambahkan satu baris di dalamnya.
// ---------------------------------------------------------------------

  static const curtainRoller = Color(0xFFB99B80); // gulungan tirai


// ---------------------------------------------------------------------
// LANGKAH 2 — class MbtiConfig (Bagian 1)
// Tambahkan blok ini di dalamnya (di bawah restLabel).
// ---------------------------------------------------------------------

  static const String startLabel = 'MULAI'; // tombol bawah di kartu awal

  // Teks kartu awal.
  static const String introTitle = 'Test MBTI';
  static const String introDescription =
      'Kenali tipe kepribadianmu lewat pernyataan-pernyataan sederhana. '
      'Tidak ada jawaban benar atau salah, pilih yang paling '
      'menggambarkan dirimu.';

  // Lama animasi tirai jatuh (kartu awal dan kartu hasil).
  static const Duration curtainDuration = Duration(milliseconds: 1400);


// ---------------------------------------------------------------------
// LANGKAH 3 — class MbtiLayout (Bagian 1)
// Tambahkan dua baris ini di dalamnya.
// ---------------------------------------------------------------------

  static const double curtainRollerHeight = 18; // tebal gulungan tirai
  static const double curtainRollerOverhang = 6; // gulungan lebih lebar dari kartu


// ---------------------------------------------------------------------
// LANGKAH 4 — Bagian 4 (alur halaman)
//
// 4a. GANTI baris enum:
//       enum _Phase { question, rest, result }
//     menjadi:
// ---------------------------------------------------------------------

enum _Phase { intro, question, rest, result }

// 4b. Di class _TestMbtiPageState, GANTI baris:
//       _Phase _phase = _Phase.question;
//     menjadi:

  _Phase _phase = _Phase.intro;

// 4c. TAMBAHKAN method ini (misalnya di atas `_handleNext`):

  // Dari kartu awal: mulai tes.
  void _startTest() {
    setState(() {
      _index = 0;
      _phase = _Phase.question;
    });
  }

// 4d. GANTI method `_restart` dengan ini
//     (setelah "Ulangi Tes", kartu awal muncul lagi lengkap dengan tirainya):

  void _restart() {
    setState(() {
      _answers.fillRange(0, _total, null);
      _index = 0;
      _outcome = null;
      _phase = _Phase.intro;
    });
  }


// ---------------------------------------------------------------------
// LANGKAH 5 — GANTI seluruh method `_buildBody` dengan ini.
// Perubahan: ada case intro, dan kartu hasil dibungkus _CurtainReveal.
// `key` wajib ada agar animasi diulang setiap kartunya muncul kembali.
// ---------------------------------------------------------------------

  List<Widget> _buildBody() {
    switch (_phase) {
      case _Phase.intro:
        return [
          const _CurtainReveal(
            key: ValueKey('intro-curtain'),
            child: _IntroCard(),
          ),
        ];

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
          // Progress bar tetap muncul pada papan jeda.
          _ProgressHeader(
            current: _index + 1,
            total: _total,
          ),
          const SizedBox(height: MbtiLayout.progressToCard),
          _RestCard(
            answered: _index + 1,
            total: _total,
          ),
        ];

      case _Phase.result:
        return [
          // Tidak ada progress bar pada halaman hasil.
          _CurtainReveal(
            key: const ValueKey('result-curtain'),
            child: _ResultCard(outcome: _outcome!),
          ),
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


// ---------------------------------------------------------------------
// LANGKAH 6 — tombol NEXT di bawah (masih di Bagian 4)
//
// 6a. TAMBAHKAN method ini di class _TestMbtiPageState
//     (misalnya di bawah `_buildBody`):
// ---------------------------------------------------------------------

  // Tombol hijau di bawah, isinya mengikuti tahap yang sedang berjalan.
  Widget _buildBottomBar() {
    switch (_phase) {
      case _Phase.intro:
        return _NextBar(
          label: MbtiConfig.startLabel,
          enabled: true,
          onNext: _startTest,
          onPrev: null,
        );

      case _Phase.question:
        return _NextBar(
          label: _index == _total - 1
              ? MbtiConfig.finishLabel
              : MbtiConfig.nextLabel,
          enabled: _answers[_index] != null,
          onNext: _handleNext,
          onPrev: _index > 0 ? _handlePrevious : null,
        );

      case _Phase.rest:
        return _NextBar(
          label: MbtiConfig.restLabel,
          enabled: true,
          onNext: _continueAfterRest,
          onPrev: _backFromRest,
        );

      case _Phase.result:
        return const SizedBox.shrink();
    }
  }

// 6b. Di method build(), HAPUS baris:
//       final isLastQuestion = _index == _total - 1;
//
// 6c. Masih di build(), GANTI seluruh blok
//     "// 3. TOMBOL NEXT DI BAWAH" (dari `if (showBar)` sampai tanda `,`
//     penutup Positioned-nya) dengan ini:

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


// ---------------------------------------------------------------------
// LANGKAH 7 — TAMBAHKAN tiga class ini di Bagian 6
// (misalnya tepat di atas `class _QuestionCard`).
// ---------------------------------------------------------------------

// Animasi tirai jatuh: isi dibuka dari atas ke bawah, dan gulungan
// mengikuti ujung bawahnya. Animasi jalan sekali saat widget muncul.
// Tinggi isi tidak perlu diketahui, jadi cocok untuk kartu hasil.
class _CurtainReveal extends StatefulWidget {
  const _CurtainReveal({super.key, required this.child});

  final Widget child;

  @override
  State<_CurtainReveal> createState() => _CurtainRevealState();
}

class _CurtainRevealState extends State<_CurtainReveal>
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
                      color: MbtiColors.curtainRoller,
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
class _ScaleToFit extends StatelessWidget {
  const _ScaleToFit({required this.child});

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

// Kartu awal sebelum tes dimulai. Tingginya sama dengan kartu soal.
class _IntroCard extends StatelessWidget {
  const _IntroCard();

  @override
  Widget build(BuildContext context) {
    final notes = [
      '${mbtiQuestions.length} soal',
      'Jeda istirahat setiap ${MbtiConfig.restEvery} soal',
      'Hasil muncul setelah semua soal dijawab',
    ];

    return _CardShell(
      height: MbtiLayout.cardHeight,
      child: _ScaleToFit(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              MbtiConfig.introTitle,
              style: MbtiText.heading.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 14),
            Text(
              MbtiConfig.introDescription,
              textAlign: TextAlign.center,
              style: MbtiText.question,
            ),
            const SizedBox(height: 20),
            for (final note in notes)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  '•  $note',
                  textAlign: TextAlign.center,
                  style: MbtiText.answer,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
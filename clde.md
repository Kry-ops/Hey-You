// =====================================================================
// UPDATE KARTU SOAL — ukuran kartu selalu sama untuk semua soal.
// Ada 4 perubahan. Semua nilai dan import lain di filemu tetap dipakai.
// =====================================================================


// ---------------------------------------------------------------------
// 1) class MbtiLayout (Bagian 1)
//    Tambahkan blok ini di bawah `cardDotSize`.
// ---------------------------------------------------------------------

  // ---------------------------------------------------------------
  // UKURAN KARTU SOAL
  // Tinggi kartu dihitung dari nilai-nilai di bawah, jadi selalu sama
  // untuk semua soal, entah teksnya pendek atau panjang.
  // ---------------------------------------------------------------
  static const double cardPaddingTop = 30; // tepi atas kartu ke area soal
  static const double cardPaddingSide = 20; // tepi kiri-kanan kartu
  static const double cardPaddingBottom = cardCurveDepth + 14; // ruang bawah
  static const double questionToAnswers = 28; // area soal ke jawaban pertama
  static const int questionLines = 3; // area soal setinggi sekian baris

  // Tinggi area soal = jumlah baris x tinggi satu baris teks.
  static double get questionAreaHeight =>
      questionLines *
      (MbtiText.question.fontSize! * MbtiText.question.height!);

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


// ---------------------------------------------------------------------
// 2) class _CardShell (Bagian 6)
//    GANTI seluruh class-nya dengan ini.
//    Tanpa `height`, tinggi kartu mengikuti isi (dipakai kartu hasil).
// ---------------------------------------------------------------------

class _CardShell extends StatelessWidget {
  const _CardShell({required this.child, this.height});

  final Widget child;
  final double? height; // null = tinggi mengikuti isi

  @override
  Widget build(BuildContext context) {
    // Jika tinggi ditentukan, isi diletakkan di tengah area kartu.
    final content = height == null
        ? child
        : SizedBox(
            width: double.infinity,
            height: height! -
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
// 3) class _QuestionCard (Bagian 6)
//    GANTI seluruh class-nya dengan ini.
//    Teks soal memakai area bertinggi tetap. Kalau ada soal yang
//    lebih panjang dari area itu, ukuran hurufnya mengecil otomatis.
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
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth,
                    ),
                    child: Text(
                      question,
                      textAlign: TextAlign.center,
                      style: MbtiText.question,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: MbtiLayout.questionToAnswers),

          // Pilihan jawaban
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


// ---------------------------------------------------------------------
// 4) class _RestCard (Bagian 6)
//    Hanya ubah 2 baris di awal build(), supaya kartu istirahat
//    berukuran sama dengan kartu soal (tidak melompat saat berganti):
//
//    SEBELUM:
//      return _CardShell(
//        child: Column(
//          children: [
//
//    SESUDAH:
//      return _CardShell(
//        height: MbtiLayout.cardHeight,
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: [
//
//    Bagian lainnya di _RestCard tidak berubah.
// ---------------------------------------------------------------------
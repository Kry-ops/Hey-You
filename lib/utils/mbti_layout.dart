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





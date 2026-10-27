// BAGIAN 2 — DAFTAR SOAL
// 4 kelompok x 15 soal = 60 soal. Soal ditampilkan selang-seling
// antar kelompok. Jumlah total otomatis mengikuti isi daftar.
//
// Parameter kedua = huruf MBTI yang DIDUKUNG jika user menjawab "Setuju".
//   E / I = Extrovert / Introvert     S / N = Sensing / Intuition
//   T / F = Thinking / Feeling        J / P = Judging / Perceiving
class MbtiQuestion {
  const MbtiQuestion(this.text, this.letter);
  final String text;
  final String letter;
}

const List<MbtiQuestion> _questionsEI = [
  MbtiQuestion('Energimu terasa cepat habis setelah bertemu banyak orang baru.', 'I'),
  MbtiQuestion('Kamu mudah memulai obrolan dengan orang yang baru kamu kenal.', 'E'),
  MbtiQuestion('Kamu lebih suka menghabiskan akhir pekan sendirian atau bersama satu-dua orang dekat.', 'I'),
  MbtiQuestion('Berada di tengah keramaian membuatmu bersemangat.', 'E'),
  MbtiQuestion('Kamu perlu waktu sendiri untuk memulihkan tenaga setelah acara ramai.', 'I'),
  MbtiQuestion('Kamu biasanya berpikir sambil berbicara dengan orang lain.', 'E'),
  MbtiQuestion('Kamu lebih nyaman mendengarkan daripada menjadi pusat perhatian.', 'I'),
  MbtiQuestion('Kamu punya banyak teman dan senang menambah kenalan baru.', 'E'),
  MbtiQuestion('Kamu berpikir matang dulu sebelum bicara dalam diskusi kelompok.', 'I'),
  MbtiQuestion('Kamu cepat akrab dalam situasi sosial yang baru.', 'E'),
  MbtiQuestion('Kamu merasa lebih produktif saat bekerja sendiri.', 'I'),
  MbtiQuestion('Kamu sering menjadi orang yang memulai ajakan berkumpul.', 'E'),
  MbtiQuestion('Percakapan ringan dengan orang asing terasa melelahkan bagimu.', 'I'),
  MbtiQuestion('Kamu mudah bosan kalau terlalu lama sendirian.', 'E'),
  MbtiQuestion('Kamu lebih suka punya sedikit teman dekat daripada banyak kenalan.', 'I'),
];

const List<MbtiQuestion> _questionsSN = [
  MbtiQuestion('Kamu lebih percaya pada fakta dan pengalaman nyata daripada firasat.', 'S'),
  MbtiQuestion('Kamu sering memikirkan berbagai kemungkinan di masa depan.', 'N'),
  MbtiQuestion('Kamu lebih suka petunjuk yang jelas dan langkah-langkah yang konkret.', 'S'),
  MbtiQuestion('Kamu mudah tertarik pada ide-ide baru yang tidak biasa.', 'N'),
  MbtiQuestion('Kamu memperhatikan detail-detail kecil di sekitarmu.', 'S'),
  MbtiQuestion('Kamu suka mencari makna atau pola di balik suatu kejadian.', 'N'),
  MbtiQuestion('Kamu lebih nyaman dengan cara kerja yang sudah terbukti berhasil.', 'S'),
  MbtiQuestion('Kamu sering melamun atau membayangkan hal yang belum terjadi.', 'N'),
  MbtiQuestion('Kamu lebih suka membicarakan hal-hal yang nyata dan praktis.', 'S'),
  MbtiQuestion('Kamu suka berpikir dengan analogi atau perumpamaan.', 'N'),
  MbtiQuestion('Kamu belajar paling baik lewat praktik langsung.', 'S'),
  MbtiQuestion('Kamu lebih tertarik pada gambaran besar daripada rincian.', 'N'),
  MbtiQuestion('Kamu lebih mengandalkan pengalaman nyata saat mengambil keputusan.', 'S'),
  MbtiQuestion('Kamu mudah bosan dengan rutinitas dan ingin mencoba cara baru.', 'N'),
  MbtiQuestion('Kamu menyukai hal-hal yang bisa dilihat, disentuh, dan dibuktikan.', 'S'),
];

const List<MbtiQuestion> _questionsTF = [
  MbtiQuestion('Saat mengambil keputusan, kamu mengutamakan logika daripada perasaan.', 'T'),
  MbtiQuestion('Kamu mudah ikut merasakan perasaan orang lain.', 'F'),
  MbtiQuestion('Kamu lebih suka kritik yang jujur dan apa adanya.', 'T'),
  MbtiQuestion('Menjaga keharmonisan sama pentingnya bagimu dengan menjadi benar.', 'F'),
  MbtiQuestion('Kamu cenderung menilai suatu masalah secara objektif.', 'T'),
  MbtiQuestion('Kamu sering mempertimbangkan perasaan orang sebelum berbicara.', 'F'),
  MbtiQuestion('Bagimu, bersikap adil lebih penting daripada bersikap belas kasihan.', 'T'),
  MbtiQuestion('Kamu mudah tersentuh oleh cerita orang lain.', 'F'),
  MbtiQuestion('Kamu tetap bisa berpikir jernih saat orang di sekitarmu sedang emosional.', 'T'),
  MbtiQuestion('Nilai-nilai pribadimu sangat memengaruhi keputusanmu.', 'F'),
  MbtiQuestion('Kamu suka berdebat untuk menguji sebuah gagasan.', 'T'),
  MbtiQuestion('Kamu lebih suka menolong orang daripada menganalisis masalahnya.', 'F'),
  MbtiQuestion('Kamu menilai sesuatu dari kebenarannya, bukan dari rasa suka.', 'T'),
  MbtiQuestion('Kamu merasa tidak enak jika harus menolak permintaan orang lain.', 'F'),
  MbtiQuestion('Kamu bisa mengambil keputusan tegas meskipun ada yang kecewa.', 'T'),
];

const List<MbtiQuestion> _questionsJP = [
  MbtiQuestion('Kamu suka membuat rencana sebelum memulai sesuatu.', 'J'),
  MbtiQuestion('Kamu lebih suka mengikuti arus daripada terikat jadwal.', 'P'),
  MbtiQuestion('Kamu merasa tenang kalau pekerjaan selesai jauh sebelum tenggat.', 'J'),
  MbtiQuestion('Kamu sering menyelesaikan tugas mendekati tenggat waktu.', 'P'),
  MbtiQuestion('Kamu suka barang dan jadwalmu tertata rapi.', 'J'),
  MbtiQuestion('Kamu senang membiarkan pilihan tetap terbuka selama mungkin.', 'P'),
  MbtiQuestion('Kamu tidak nyaman jika rencanamu tiba-tiba berubah.', 'J'),
  MbtiQuestion('Kamu menikmati kejutan dan hal-hal yang spontan.', 'P'),
  MbtiQuestion('Kamu cepat mengambil keputusan lalu langsung menjalankannya.', 'J'),
  MbtiQuestion('Kamu lebih suka menyesuaikan diri di tengah jalan daripada mengikuti rencana awal.', 'P'),
  MbtiQuestion('Kamu memakai daftar tugas atau kalender untuk mengatur kegiatanmu.', 'J'),
  MbtiQuestion('Kamu bisa bekerja dengan baik tanpa jadwal yang pasti.', 'P'),
  MbtiQuestion('Kamu merasa lega setelah suatu keputusan benar-benar ditetapkan.', 'J'),
  MbtiQuestion('Kamu sering baru mulai mengerjakan sesuatu saat sedang ingin.', 'P'),
  MbtiQuestion('Kamu tidak suka menunda pekerjaan.', 'J'),
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


// BAGIAN 3 — HASIL (16 TIPE MBTI) DAN PERHITUNGAN

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

const List<List<String>> pairs = [
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

const Map<String, String> letterNames = {
  'E': 'Extrovert', 'I': 'Introvert',
  'S': 'Sensing', 'N': 'Intuition',
  'T': 'Thinking', 'F': 'Feeling',
  'J': 'Judging', 'P': 'Perceiving',
};
// Hasil perhitungan: tipe (contoh 'INFP') dan persentase huruf pertama
// dari tiap pasangan (E, S, T, J).

class MbtiOutcome {
  const MbtiOutcome(this.type, this.firstPercents);
  final String type;
  final List<double> firstPercents;
}
// Skor tiap jawaban: Sangat Setuju = +2 ... Sangat Tidak Setuju = -2.
// Jawaban setuju menambah poin huruf soal, tidak setuju menambah
// poin huruf lawannya. Jika skor seri, dipilih huruf kedua (I, N, F, P).
MbtiOutcome calculateOutcome(List<int?> answers) {
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
  for (final pair in pairs) {
    final first = points[pair[0]]!;
    final second = points[pair[1]]!;
    final total = first + second;
    percents.add(total == 0 ? 0.5 : first / total);
    type += first > second ? pair[0] : pair[1];
  }
  return MbtiOutcome(type, percents);
}

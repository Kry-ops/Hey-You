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

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

import '../service/audio_manager.dart';

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
    AudioManager.instance.playEffect('assets/music_assets/mbti_sound_assets/back_sound.MP3');
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
    // Efek suara saat jawaban dipilih.
    AudioManager.instance.playEffect('assets/music_assets/mbti_sound_assets/pencil_sound.MP3');

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
    AudioManager.instance.playEffect('button_next.wav');
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
    AudioManager.instance.playEffect('assets/music_assets/mbti_sound_assets/next_sound.MP3');
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
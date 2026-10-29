// music_popup.dart
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../service/audio_manager.dart';

class MusicPopup extends StatefulWidget {
  const MusicPopup({super.key});

  @override
  State<MusicPopup> createState() => _MusicPopupState();
}

class _MusicPopupState extends State<MusicPopup> {
  final AudioManager _audio = AudioManager.instance;

  late Set<String> _draftSelection;

  @override
  void initState() {
    super.initState();

    // Salin pilihan yang aktif agar perubahan checkbox
    // baru diterapkan setelah tombol Apply ditekan.
    _draftSelection = Set<String>.from(_audio.selectedIds);
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 22),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 390),
        child: Container(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 20),
          decoration: BoxDecoration(
            color: AppColors.dark,
            borderRadius: BorderRadius.circular(32),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // JUDUL POPUP
                const Text(
                  'Music',
                  style: TextStyle(
                    color: AppColors.cream,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),

                const SizedBox(height: 12),

                // PANEL PEMUTAR
                _buildPlayer(),

                const SizedBox(height: 20),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Music List:',
                    style: TextStyle(
                      color: AppColors.cream,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // PLAYLIST DENGAN TINGGI TETAP
                SizedBox(
                  height: 224,
                  child: Scrollbar(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: AudioManager.tracks.length,
                      itemBuilder: (context, index) {
                        final track = AudioManager.tracks[index];
                        final checked =
                            _draftSelection.contains(track.id);

                        return SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 28,
                                child: Checkbox(
                                  value: checked,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == true) {
                                        _draftSelection.add(track.id);
                                      } else {
                                        _draftSelection.remove(track.id);
                                      }
                                    });
                                  },
                                  activeColor: AppColors.green,
                                  checkColor: AppColors.cream,
                                  side: BorderSide.none,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(6),
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity:
                                      VisualDensity.compact,
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  '${track.title} by ${track.artist}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColors.cream,
                                    fontSize: 12.5,
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

                const SizedBox(height: 14),

                // APPLY
                FilledButton(
                  onPressed: () async {
                    await _audio.applyPlaylist(_draftSelection);

                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.green,
                    foregroundColor: AppColors.cream,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
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

  Widget _buildPlayer() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // NAMA LAGU YANG SEDANG DIPUTAR
          ValueListenableBuilder(
            valueListenable: _audio.currentTrack,
            builder: (context, track, _) {
              return Column(
                children: [
                  Text(
                    track?.title ?? 'No Music Selected',//the tittle isnt defined
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.dark,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    track?.artist ?? 'Pilih lagu untuk memulai',//the getter artist isnt defined
                    style: const TextStyle(
                      color: AppColors.dark,
                      fontSize: 10,
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 10),

          // PROGRESS BAR DAN DURASI
          StreamBuilder<Duration>(
            stream: _audio.musicPlayer.onPositionChanged,
            initialData: Duration.zero,
            builder: (context, positionSnapshot) {
              final position =
                  positionSnapshot.data ?? Duration.zero;

              return StreamBuilder<Duration>(
                stream: _audio.musicPlayer.onDurationChanged,
                builder: (context, durationSnapshot) {
                  final duration =
                      durationSnapshot.data ?? Duration.zero;

                  final maxMs = duration.inMilliseconds > 0
                      ? duration.inMilliseconds.toDouble()
                      : 1.0;

                  final currentMs = position.inMilliseconds
                      .toDouble()
                      .clamp(0.0, maxMs);

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(position),
                            style: const TextStyle(
                              color: AppColors.dark,
                              fontSize: 9,
                            ),
                          ),
                          Text(
                            _formatDuration(duration),
                            style: const TextStyle(
                              color: AppColors.dark,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 3,
                            thumbShape:
                                const RoundSliderThumbShape(
                              enabledThumbRadius: 0,
                            ),
                            overlayShape:
                                const RoundSliderOverlayShape(
                              overlayRadius: 8,
                            ),
                            activeTrackColor: AppColors.green,
                            inactiveTrackColor: AppColors.dark
                                .withValues(alpha: 0.3),
                            thumbColor: AppColors.green,
                          ),
                          child: Slider(
                            min: 0,
                            max: maxMs,
                            value: currentMs,
                            onChanged: duration.inMilliseconds <= 0
                                ? null
                                : (value) {
                                    _audio.musicPlayer.seek(
                                      Duration(
                                        milliseconds: value.round(),
                                      ),
                                    );
                                  },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          const SizedBox(height: 2),

          // KONTROL PEMUTAR
          ValueListenableBuilder<bool>(
            valueListenable: _audio.isPlaying,
            builder: (context, playing, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    tooltip: 'Previous',
                    onPressed: _audio.previous,
                    icon: const Icon(
                      Icons.skip_previous_rounded,
                      color: AppColors.dark,
                      size: 26,
                    ),
                  ),
                  IconButton(
                    tooltip: playing ? 'Pause' : 'Play',
                    onPressed: _audio.togglePlayPause,
                    icon: Icon(
                      playing
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: AppColors.dark,
                      size: 36,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Next',
                    onPressed: _audio.next,
                    icon: const Icon(
                      Icons.skip_next_rounded,
                      color: AppColors.dark,
                      size: 26,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

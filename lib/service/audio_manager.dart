
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

// ============================================================
// DATA LAGU
// ============================================================

class MusicTrack {
  const MusicTrack({
    required this.id,
    required this.title,
    required this.artist,
    required this.asset,
  });

  final String id;
  final String title;
  final String artist;
  final String asset;
}

// ============================================================
// AUDIO MANAGER
// ============================================================

class AudioManager {
  AudioManager._() {
    _musicPlayer.onPlayerComplete.listen((_) {
      _playNext();
    });
  }

  static final AudioManager instance = AudioManager._();

  final AudioPlayer _musicPlayer = AudioPlayer();
  final AudioPlayer _effectPlayer = AudioPlayer();

  // ==========================================================
  // DAFTAR BACKSOUND
  // Path dimulai dari dalam folder assets/, bukan assets/
  // ==========================================================

  static const List<MusicTrack> tracks = [
    MusicTrack(
      id: 'split_memmories',
      title: 'Split Memmories',
      artist: 'Idoberg',
      asset:
          'music_assets/backsound_music_assets/split_memmories_by_idoberg.mp3',
    ),
  ];

  // Lagu yang dicentang secara default.
  final Set<String> _selectedIds = {
    'split_memmories',
  };

  Set<String> get selectedIds => Set.unmodifiable(_selectedIds);

  final ValueNotifier<MusicTrack?> currentTrack =
      ValueNotifier<MusicTrack?>(null);

  final ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);

  AudioPlayer get musicPlayer => _musicPlayer;

  List<MusicTrack> get selectedTracks => tracks
      .where((track) => _selectedIds.contains(track.id))
      .toList();

  int _currentIndex = -1;
  bool _started = false;

  // ==========================================================
  // AUTO PLAY SAAT HOME DIBUKA
  // ==========================================================

  Future<void> startIfNeeded() async {
    if (_started) return;

    final queue = selectedTracks;
    if (queue.isEmpty) return;

    _started = true;
    await _playTrack(queue.first);
  }

  // ==========================================================
  // TERAPKAN PILIHAN PLAYLIST
  // ==========================================================

  Future<void> applyPlaylist(Set<String> ids) async {
    _selectedIds
      ..clear()
      ..addAll(ids);

    final queue = selectedTracks;

    if (queue.isEmpty) {
      _started = false;
      _currentIndex = -1;

      await _musicPlayer.stop();
      currentTrack.value = null;
      isPlaying.value = false;
      return;
    }

    final current = currentTrack.value;

    // Pertahankan lagu aktif jika masih dipilih.
    if (current != null &&
        _selectedIds.contains(current.id) &&
        isPlaying.value) {
      _currentIndex = queue.indexWhere(
        (track) => track.id == current.id,
      );
      _started = true;
      return;
    }

    _started = true;
    await _playTrack(
      current != null && _selectedIds.contains(current.id)
          ? current
          : queue.first,
    );
  }

  // ==========================================================
  // PUTAR LAGU
  // ==========================================================

  Future<void> _playTrack(MusicTrack track) async {
    final queue = selectedTracks;
    if (queue.isEmpty) return;

    _currentIndex = queue.indexWhere(
      (item) => item.id == track.id,
    );

    if (_currentIndex < 0) return;

    currentTrack.value = track;

    await _musicPlayer.play(
      AssetSource(track.asset),
      volume: 0.35,
    );

    isPlaying.value = true;
  }

  // ==========================================================
  // PLAY / PAUSE
  // ==========================================================

  Future<void> togglePlayPause() async {
    if (selectedTracks.isEmpty) return;

    if (isPlaying.value) {
      await _musicPlayer.pause();
      isPlaying.value = false;
    } else {
      if (currentTrack.value == null) {
        await startIfNeeded();
      } else {
        await _musicPlayer.resume();
        isPlaying.value = true;
      }
    }
  }

  // ==========================================================
  // NEXT / PREVIOUS
  // ==========================================================

  Future<void> next() async {
    await _playNext();
  }

  Future<void> previous() async {
    final queue = selectedTracks;
    if (queue.isEmpty) return;

    if (_currentIndex <= 0) {
      await _playTrack(queue.last);
    } else {
      await _playTrack(queue[_currentIndex - 1]);
    }
  }

  Future<void> _playNext() async {
    final queue = selectedTracks;

    if (queue.isEmpty) {
      _started = false;
      currentTrack.value = null;
      isPlaying.value = false;
      return;
    }

    final nextIndex = (_currentIndex + 1) % queue.length;
    await _playTrack(queue[nextIndex]);
  }

  // ==========================================================
  // SOUND EFFECT MBTI
  // ==========================================================

  Future<void> playEffect(String fileName) async {
    await _effectPlayer.play(
      AssetSource('music_assets/$fileName'),
      volume: 0.75,
    );
  }
}

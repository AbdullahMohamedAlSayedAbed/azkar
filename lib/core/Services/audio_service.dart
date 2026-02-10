/// Audio Service
/// Handles audio playback for Quran recitation and tasbeeh sounds
library;

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

enum AudioPlayerState {
  idle,
  loading,
  playing,
  paused,
  completed,
  error,
}

class AppAudioService {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  Stream<AudioPlayerState> get stateStream =>
      _player.playerStateStream.map((state) {
        if (state.processingState == ProcessingState.loading ||
            state.processingState == ProcessingState.buffering) {
          return AudioPlayerState.loading;
        } else if (state.processingState == ProcessingState.completed) {
          return AudioPlayerState.completed;
        } else if (state.playing) {
          return AudioPlayerState.playing;
        } else {
          return AudioPlayerState.paused;
        }
      });

  Stream<Duration> get positionStream => _player.positionStream;

  Stream<Duration?> get durationStream => _player.durationStream;

  Duration get position => _player.position;

  Duration? get duration => _player.duration;

  bool get isPlaying => _player.playing;

  /// Load audio from URL (for Quran recitation)
  Future<void> loadUrl(String url) async {
    try {
      await _player.setUrl(url);
    } catch (e) {
      debugPrint('Error loading audio URL: $e');
      rethrow;
    }
  }

  /// Load audio from asset
  Future<void> loadAsset(String assetPath) async {
    try {
      await _player.setAsset(assetPath);
    } catch (e) {
      debugPrint('Error loading audio asset: $e');
      rethrow;
    }
  }

  /// Play audio
  Future<void> play() async {
    await _player.play();
  }

  /// Pause audio
  Future<void> pause() async {
    await _player.pause();
  }

  /// Stop audio
  Future<void> stop() async {
    await _player.stop();
  }

  /// Toggle play/pause
  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await pause();
    } else {
      await play();
    }
  }

  /// Seek to position
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  /// Set playback speed
  Future<void> setSpeed(double speed) async {
    await _player.setSpeed(speed);
  }

  /// Set volume (0.0 to 1.0)
  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
  }

  /// Set loop mode
  Future<void> setLoopMode(LoopMode mode) async {
    await _player.setLoopMode(mode);
  }

  /// Play simple sound effect (tasbeeh click, etc.)
  Future<void> playSoundEffect(String assetPath) async {
    final effectPlayer = AudioPlayer();
    try {
      await effectPlayer.setAsset(assetPath);
      await effectPlayer.play();
      effectPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          effectPlayer.dispose();
        }
      });
    } catch (e) {
      debugPrint('Error playing sound effect: $e');
      effectPlayer.dispose();
    }
  }

  /// Dispose
  void dispose() {
    _player.dispose();
  }
}

import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';

/// Audio service that manages offline-first audio playback for the Devi app.
/// Uses distinct AudioPlayer instances for SFX (e.g. chime) and Mantra chanting.
class AudioService {
  AudioPlayer? _mantraPlayer;
  AudioPlayer? _sfxPlayer;

  /// Lightweight player used only to read a clip's duration without playing it.
  /// Kept separate so probing never disturbs the active mantra playback.
  AudioPlayer? _probePlayer;
  final bool _isTest;

  /// Listens to application lifecycle events.
  AppLifecycleListener? _lifecycleListener;

  /// Stores the last processed application lifecycle state (for testing).
  AppLifecycleState? lastLifecycleState;

  AudioService() : _isTest = Platform.environment.containsKey('FLUTTER_TEST') {
    if (!_isTest) {
      try {
        _mantraPlayer = AudioPlayer();
        _sfxPlayer = AudioPlayer();
        _mantraPlayer!.setReleaseMode(ReleaseMode.stop);
        _sfxPlayer!.setReleaseMode(ReleaseMode.stop);
      } catch (e) {
        debugPrint('AudioService: Failed to initialize AudioPlayer: $e');
      }
    }

    // Register lifecycle listener to pause/stop audio when app is minimized or backgrounded
    _lifecycleListener = AppLifecycleListener(
      onStateChange: (state) {
        debugPrint('AudioService: App lifecycle state changed to: $state');
        lastLifecycleState = state;
        if (state == AppLifecycleState.paused ||
            state == AppLifecycleState.inactive) {
          pauseMantra();
          if (!_isTest) {
            _sfxPlayer?.stop();
          }
        }
      },
    );
  }

  /// Stream of the active mantra audio playback position.
  Stream<Duration> get onPositionChanged =>
      _isTest ? const Stream.empty() : _mantraPlayer!.onPositionChanged;

  /// Stream of the active mantra audio duration.
  Stream<Duration> get onDurationChanged =>
      _isTest ? const Stream.empty() : _mantraPlayer!.onDurationChanged;

  /// Stream of player state updates for the active mantra.
  Stream<PlayerState> get onPlayerStateChanged =>
      _isTest ? const Stream.empty() : _mantraPlayer!.onPlayerStateChanged;

  /// Stream triggering when the active mantra finishes playing.
  Stream<void> get onMantraComplete =>
      _isTest ? const Stream.empty() : _mantraPlayer!.onPlayerComplete;

  /// Check if a mantra is currently playing.
  bool get isMantraPlaying =>
      _isTest ? false : (_mantraPlayer?.state == PlayerState.playing);

  /// Clean asset path by removing 'assets/' prefix if present
  String _cleanAssetPath(String path) {
    if (path.startsWith('assets/')) {
      return path.substring('assets/'.length);
    }
    return path;
  }

  /// Play the temple bell chime effect.
  Future<void> playChime() async {
    if (_isTest) {
      debugPrint('AudioService: Mock playing chime SFX in test mode.');
      return;
    }
    try {
      debugPrint('AudioService: Playing chime SFX...');
      await _sfxPlayer!.stop();
      await _sfxPlayer!.play(
        AssetSource(_cleanAssetPath('assets/audio/sfx/chime.mp3')),
      );
    } catch (e, stack) {
      debugPrint('AudioService error playing chime: $e\n$stack');
    }
  }

  /// Play a specific Navadurga mantra chant.
  /// Stops any previously playing mantra audio.
  Future<void> playMantra(String path) async {
    if (_isTest) {
      debugPrint('AudioService: Mock playing mantra at $path in test mode.');
      return;
    }
    try {
      debugPrint('AudioService: Loading and playing mantra at $path...');
      await _mantraPlayer!.stop();
      final cleanPath = _cleanAssetPath(path);
      await _mantraPlayer!.play(AssetSource(cleanPath));
    } catch (e, stack) {
      debugPrint('AudioService error playing mantra ($path): $e\n$stack');
    }
  }

  /// Read the total duration of a mantra clip without playing it.
  ///
  /// Uses a dedicated probe player so it never interferes with the active
  /// mantra playback. Returns `null` in test mode or if the duration can't be
  /// determined, letting callers fall back to a default.
  Future<Duration?> getMantraDuration(String path) async {
    if (_isTest) return null;
    try {
      _probePlayer ??= AudioPlayer();
      final cleanPath = _cleanAssetPath(path);
      await _probePlayer!.setSource(AssetSource(cleanPath));
      return await _probePlayer!.getDuration();
    } catch (e) {
      debugPrint('AudioService error reading duration ($path): $e');
      return null;
    }
  }

  /// Seek to a specific position in the active mantra.
  Future<void> seek(Duration position) async {
    if (_isTest) return;
    try {
      await _mantraPlayer!.seek(position);
    } catch (e) {
      debugPrint('AudioService error seeking: $e');
    }
  }

  /// Pause the currently playing mantra.
  Future<void> pauseMantra() async {
    if (_isTest) return;
    try {
      if (_mantraPlayer!.state == PlayerState.playing) {
        await _mantraPlayer!.pause();
      }
    } catch (e) {
      debugPrint('AudioService error pausing mantra: $e');
    }
  }

  /// Resume the paused mantra.
  Future<void> resumeMantra() async {
    if (_isTest) return;
    try {
      if (_mantraPlayer!.state == PlayerState.paused) {
        await _mantraPlayer!.resume();
      }
    } catch (e) {
      debugPrint('AudioService error resuming mantra: $e');
    }
  }

  /// Stop playing the active mantra.
  Future<void> stopMantra() async {
    if (_isTest) return;
    try {
      await _mantraPlayer!.stop();
    } catch (e) {
      debugPrint('AudioService error stopping mantra: $e');
    }
  }

  /// Stop all playback (mantras and SFX).
  Future<void> stopAll() async {
    if (_isTest) return;
    try {
      await Future.wait([_mantraPlayer!.stop(), _sfxPlayer!.stop()]);
    } catch (e) {
      debugPrint('AudioService error stopping all audio: $e');
    }
  }

  /// Dispose player instances when the service is destroyed.
  Future<void> dispose() async {
    _lifecycleListener?.dispose();
    if (_isTest) return;
    try {
      await _mantraPlayer?.dispose();
      await _sfxPlayer?.dispose();
      await _probePlayer?.dispose();
    } catch (e) {
      debugPrint('AudioService error disposing players: $e');
    }
  }
}

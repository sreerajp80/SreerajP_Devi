import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import '../core/constants/app_colors.dart';
import '../core/providers/providers.dart';

/// A premium visual audio controller designed to be placed at the bottom of the card back.
/// It hooks up directly to the [AudioService] to display and control audio playback.
class AudioPlayerBar extends ConsumerStatefulWidget {
  /// The audio asset path associated with this card's Durga mantra.
  final String audioPath;

  const AudioPlayerBar({super.key, required this.audioPath});

  @override
  ConsumerState<AudioPlayerBar> createState() => _AudioPlayerBarState();
}

class _AudioPlayerBarState extends ConsumerState<AudioPlayerBar> {
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<PlayerState>? _stateSubscription;
  StreamSubscription<void>? _completeSubscription;

  Duration _position = Duration.zero;
  Duration _duration = const Duration(
    seconds: 30,
  ); // reasonable fallback default
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initAudioSubscriptions();
    });
  }

  void _initAudioSubscriptions() {
    if (!mounted) return;
    final audioService = ref.read(audioServiceProvider);

    setState(() {
      _isPlaying = audioService.isMantraPlaying;
    });

    // Load the real clip duration up front so the card shows the correct
    // length before playback ever starts, instead of the 30s fallback.
    audioService.getMantraDuration(widget.audioPath).then((dur) {
      if (!mounted || dur == null || dur.inMilliseconds <= 0) return;
      setState(() {
        _duration = dur;
      });
    });

    _positionSubscription = audioService.onPositionChanged.listen((pos) {
      if (!mounted) return;
      setState(() {
        _position = pos;
      });
    });

    _durationSubscription = audioService.onDurationChanged.listen((dur) {
      if (!mounted) return;
      // AudioPlayer sometimes reports zero or empty durations initially, skip those
      if (dur.inSeconds > 0) {
        setState(() {
          _duration = dur;
        });
      }
    });

    _stateSubscription = audioService.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    _completeSubscription = audioService.onMantraComplete.listen((_) {
      if (!mounted) return;
      setState(() {
        _position = Duration.zero;
        _isPlaying = false;
      });
    });
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _stateSubscription?.cancel();
    _completeSubscription?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final seconds = duration.inSeconds;
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final audioService = ref.read(audioServiceProvider);

    // Ensure we don't divide by zero
    final double progress = _duration.inMilliseconds > 0
        ? (_position.inMilliseconds / _duration.inMilliseconds).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.haridraBackground.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.swarnaGold.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                _formatDuration(_position),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textDark,
                  fontFamily: 'Manjari',
                ),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.mayuraPeacock,
                    inactiveTrackColor: AppColors.swarnaGold.withValues(
                      alpha: 0.3,
                    ),
                    thumbColor: AppColors.swarnaGold,
                    overlayColor: AppColors.mayuraPeacock.withValues(
                      alpha: 0.12,
                    ),
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                    trackHeight: 3.0,
                  ),
                  child: Slider(
                    value: progress,
                    onChanged: (val) {
                      final targetMs = (val * _duration.inMilliseconds).round();
                      audioService.seek(Duration(milliseconds: targetMs));
                    },
                  ),
                ),
              ),
              Text(
                _formatDuration(_duration),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textDark,
                  fontFamily: 'Manjari',
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                key: const ValueKey('play_pause_button'),
                icon: Icon(
                  _isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                  size: 44,
                  color: AppColors.raktaRed,
                ),
                onPressed: () {
                  if (_isPlaying) {
                    audioService.pauseMantra();
                  } else {
                    // If stopped, play from start, otherwise resume
                    if (_position == Duration.zero) {
                      audioService.playMantra(widget.audioPath);
                    } else {
                      audioService.resumeMantra();
                    }
                  }
                },
              ),
              const SizedBox(width: 16),
              IconButton(
                key: const ValueKey('stop_button'),
                icon: const Icon(
                  Icons.stop_circle,
                  size: 44,
                  color: AppColors.mayuraPeacock,
                ),
                onPressed: () {
                  audioService.stopMantra();
                  audioService.seek(Duration.zero);
                  setState(() {
                    _position = Duration.zero;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

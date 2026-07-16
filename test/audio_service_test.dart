import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sreerajp_devi/core/audio/audio_service.dart';
import 'package:sreerajp_devi/core/providers/providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AudioService Tests', () {
    late AudioService audioService;

    setUp(() {
      audioService = AudioService();
    });

    tearDown(() async {
      await audioService.dispose();
    });

    test('AudioService can be instantiated and exposes status', () {
      expect(audioService, isNotNull);
      expect(audioService.isMantraPlaying, isFalse);
    });

    test('Streams are exposed correctly', () {
      expect(audioService.onPositionChanged, isNotNull);
      expect(audioService.onDurationChanged, isNotNull);
      expect(audioService.onPlayerStateChanged, isNotNull);
      expect(audioService.onMantraComplete, isNotNull);
    });

    test('Audio methods can be called without crashing', () async {
      // These will try to load assets, but in test environment, they should degrade
      // gracefully and log error instead of throwing uncaught exceptions.
      await expectLater(audioService.playChime(), completes);
      await expectLater(
        audioService.playMantra('assets/audio/mantras/1_shailaputri.mp3'),
        completes,
      );
      await expectLater(audioService.pauseMantra(), completes);
      await expectLater(audioService.resumeMantra(), completes);
      await expectLater(audioService.stopMantra(), completes);
      await expectLater(audioService.stopAll(), completes);
    });

    test('audioServiceProvider resolves correctly in ProviderScope', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final service = container.read(audioServiceProvider);
      expect(service, isNotNull);
      expect(service, isA<AudioService>());
    });

    test(
      'AudioService registers AppLifecycleListener and responds to pause/inactive',
      () async {
        final service = AudioService();

        // Initially, lastLifecycleState should be null
        expect(service.lastLifecycleState, isNull);

        // Simulate app lifecycle transitions: resumed -> inactive -> hidden -> paused
        WidgetsBinding.instance.handleAppLifecycleStateChanged(
          AppLifecycleState.inactive,
        );
        expect(service.lastLifecycleState, AppLifecycleState.inactive);

        WidgetsBinding.instance.handleAppLifecycleStateChanged(
          AppLifecycleState.hidden,
        );
        expect(service.lastLifecycleState, AppLifecycleState.hidden);

        WidgetsBinding.instance.handleAppLifecycleStateChanged(
          AppLifecycleState.paused,
        );
        expect(service.lastLifecycleState, AppLifecycleState.paused);

        // Simulate app lifecycle transitions: paused -> hidden -> inactive -> resumed
        WidgetsBinding.instance.handleAppLifecycleStateChanged(
          AppLifecycleState.hidden,
        );
        expect(service.lastLifecycleState, AppLifecycleState.hidden);

        WidgetsBinding.instance.handleAppLifecycleStateChanged(
          AppLifecycleState.inactive,
        );
        expect(service.lastLifecycleState, AppLifecycleState.inactive);

        WidgetsBinding.instance.handleAppLifecycleStateChanged(
          AppLifecycleState.resumed,
        );
        expect(service.lastLifecycleState, AppLifecycleState.resumed);

        await service.dispose();
      },
    );
  });
}

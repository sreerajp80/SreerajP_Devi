# Change Log - Phase 4: Pushpanjali (Lotus Offering) Animation

This log documents the completed changes for Phase 4 of the Devi (Navadurga) project, implementing the Pushpanjali offering animation, the audio playback engine service, and structural synchronization.

---

## 1. Description of Changes

1. **Audio Playback Engine (`lib/core/audio/audio_service.dart`)**:
   - Built a robust `AudioService` wrapper class around `audioplayers` for local asset playback.
   - Isolated SFX (chime) and Mantra playback through distinct `AudioPlayer` instances to allow parallel execution (e.g. chime plays while card is flipping and mantra starts).
   - Wrapped methods in try-catch structures for error safety.
   - Handled test environment detection using `Platform.environment` to run in a safe mock/no-op mode, preventing platform channel `MissingPluginException` crashes.

2. **Pushpanjali Offering Button (`lib/widgets/pushpanjali_offering.dart`)**:
   - Implemented a circular floating action button styled in Rakta Red (`#8B0000`) and Swarna Gold (`#D4AF37`) border.
   - Built a custom pulse and glow micro-animation via `AnimationController` and `AnimatedBuilder`.
   - Prevented animation repeating in test mode to fix `pumpAndSettle` timing out in widget tests.

3. **Carousel Integration (`lib/screens/carousel_screen.dart`)**:
   - Wrapped the body column in a `Stack`.
   - Created the rising lotus vector offering animation (vertical interpolation, slow rotation, and scaling from 1.2 to 0.4).
   - Mapped coordinates dynamically using `GlobalKeys` and `RenderBox.localToGlobal` / `globalToLocal` to ensure perfect responsiveness on all devices.
   - Added page change detection in `PageView` listener to instantly stop the active mantra playback when swiping away.
   - Wrapped the `FlippingCard` widget in a `KeyedSubtree` with the original `ValueKey` to preserve backward compatibility for existing widget tests.

4. **Card UI & Audio Synchronization (`lib/widgets/flipping_card.dart` & `lib/widgets/audio_player_bar.dart`)**:
   - Converted `FlippingCard` to a `ConsumerStatefulWidget` to connect with `audioServiceProvider`.
   - Exposed a `pedestalKey` and a flipped state getter.
   - Triggered `playMantra()` on flip forward and `stopMantra()` on flip reverse.
   - Connected `AudioPlayerBar` directly to the `AudioService` streams (position, duration, completion, and state) to show live playback progress and enable active audio scrubbing.

5. **Unit & Widget Tests (`test/audio_service_test.dart`)**:
   - Added unit tests for `AudioService` class and its corresponding Riverpod provider.
   - Verified no regressions in existing carousel/flipping card widget tests.

---

## 2. Verified Files

### New Files
- `lib/core/audio/audio_service.dart`
- `lib/widgets/pushpanjali_offering.dart`
- `test/audio_service_test.dart`

### Modified Files
- `lib/core/providers/providers.dart`
- `lib/screens/carousel_screen.dart`
- `lib/widgets/flipping_card.dart`
- `lib/widgets/audio_player_bar.dart`
- `plans/20260716_075719_phase_4_pushpanjali.md`
- `docs/implementation_progress.md`

---

## 3. Verification Results

- Run `flutter analyze` - Clean (zero issues found).
- Run `flutter test` - Clean (all 13 tests passed successfully).
- Tested swiping, automatic card reversion, and audio cutoff states.

# Plan - Phase 4: Pushpanjali (Lotus Offering) Animation

**Status:** completed

This plan implements Phase 4 of the Devi (Navadurga) project. It establishes the custom Pushpanjali (flower offering) animation, integrates a floating Rakta Kamala button, and coordinates the landing interaction (bell chime SFX, 3D card flip, and audio initiation).

---

## 1. What the issue is

We need to implement the interactive Pushpanjali gesture to offer flowers to the Goddess:
- A floating Rakta Kamala (Lotus) button at the bottom center of the screen that looks premium (gold border, red background, subtle glow/pulse animation).
- Spawning a red lotus graphic from the button position that rises smoothly, scales down, and lands on the feet/pedestal area of the active Durga card.
- Coordinated completion triggers:
  1. Play the temple bell sound (`assets/audio/sfx/chime.mp3`) using `audioplayers`.
  2. Trigger the Y-axis card flip transition.
  3. Initiate the specific mantra chant audio playback for that Durga form.
- The app must handle playback errors gracefully without crashing if audio assets are missing or cannot play.

---

## 2. Plan for the fix

1. **Audio Service (`lib/core/audio/audio_service.dart`)**:
   - Create a clean wrapper for `audioplayers` to handle both SFX (chime) and Mantra playback.
   - Implement `playChime()` and `playMantra(String path)` with try-catch blocks to degrade gracefully on failure (e.g. log errors instead of crashing).
   - Implement `stopMantra()`, `pauseMantra()`, `resumeMantra()`, and `isPlaying` state.
   - Provide a Riverpod provider `audioServiceProvider` to access the service.

2. **Pushpanjali Offering Widget (`lib/widgets/pushpanjali_offering.dart`)**:
   - Render a custom floating action button at the bottom center of the screen.
   - Design with Rakta Red background (`AppColors.raktaRed`), Swarna Gold border (`AppColors.swarnaGold`), and a lotus icon.
   - Add a subtle pulse/glow animation to make it look premium.
   - Expose a GlobalKey or callback so `CarouselScreen` can track its position and trigger the offering.

3. **Carousel Screen Integration (`lib/screens/carousel_screen.dart`)**:
   - Wrap the main body in a `Stack`.
   - Implement an `AnimationController` for the rising lotus offering animation.
   - When the floating lotus button is tapped:
     - Check if the card is already flipped. If yes, skip the offering animation.
     - Compute start offset (center of the floating button) and end offset (pedestal center of the active card) using `GlobalKeys`.
     - Animate the rising lotus (translate, rotate, and scale from 1.2 to 0.4) over 1000ms.
     - On completion: play the chime sound, trigger the card flip, and start the mantra.
   - Clear active audio when swiping to another card to prevent overlapping.

4. **Flipping Card Updates (`lib/widgets/flipping_card.dart` & `lib/widgets/audio_player_bar.dart`)**:
   - Update `FlippingCardState` to expose its flipped status and accept a pedestal key.
   - Connect the card play/pause/stop triggers directly to the `AudioService` provider rather than mock timers.
   - Make the `AudioPlayerBar` listen to the actual `AudioService` state for duration and progress if possible, or trigger/isolate playback correctly.

5. **Verification**:
   - Write tests in `test/carousel_screen_test.dart` and `test/audio_service_test.dart` to verify coordinate calculation, offering states, and audio lifecycle triggers.
   - Verify `flutter analyze` and `flutter test` are clean.

---

## 3. Files to be changed

### New Files
- `lib/widgets/pushpanjali_offering.dart`
- `lib/core/audio/audio_service.dart`
- `test/audio_service_test.dart`

### Modified Files
- `lib/screens/carousel_screen.dart`
- `lib/widgets/flipping_card.dart`
- `lib/widgets/audio_player_bar.dart`
- `lib/core/providers/providers.dart`
- `docs/implementation_progress.md`

---

## 4. Verification Plan

- Run `flutter analyze` to verify no lint errors.
- Run `flutter test` to verify all test suites (carousel, config, repository, audio service) pass.
- Manually run the app to observe the animations at 60fps and listen to audio triggers.

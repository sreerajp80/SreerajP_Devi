# Plan - Phase 3: Carousel Navigation & 3D Flipping Card

**Status:** completed

This plan implements Phase 3 of the Devi (Navadurga) project. It establishes the horizontal carousel screen (`CarouselScreen`), the 3D flipping card (`FlippingCard`), and the audio player UI (`AudioPlayerBar`).

---

## 1. What the issue is

We need to implement the main user experience for swiping through the 9 Durgas and showing their details.
This requires:
- A horizontal `PageView` showing the 9 Durgas, where the active card is highlighted and non-active cards are scaled down and dimmed.
- A 3D horizontal rotation (flip) animation on the cards. Tapping a card flips it to show its details.
- Front card design: display the portrait of the Durga and a golden pedestal at the bottom (target for Pushpanjali).
- Back card design: display the English, Sanskrit, and Malayalam names, the Sanskrit mantra, the Malayalam script translation, and the Malayalam description, along with the audio player controls layout.
- The carousel home screen should replace the current Phase 1 placeholder screen in `app.dart`.

---

## 2. Plan for the fix

1. **Carousel Screen (`carousel_screen.dart`)**:
   - Build a `ConsumerStatefulWidget` `CarouselScreen` that watches `durgasProvider`.
   - Use a `PageView.builder` with a `PageController` (viewport fraction `0.82`).
   - Implement active card focus scaling (0.88 -> 1.0) and dimming (0.6 -> 1.0) via `AnimatedBuilder` that tracks the controller's page position.
   - Maintain the active index state so we can display a page indicator or subtitle ("ഭാവം 1 / 9").

2. **Flipping Card Widget (`flipping_card.dart`)**:
   - Implement `FlippingCard` as a `StatefulWidget` with an `AnimationController` for a 180-degree Y-axis rotation.
   - Combine with `GestureDetector` to flip the card on tap.
   - Ensure the card flips back to the front when it is swiped away (i.e. `isActive` becomes false).
   - Implement `FrontCard` rendering the Durga image (with fallback styling using a beautiful gradient placeholder if loading fails) and a golden pedestal at the bottom.
   - Implement `BackCard` displaying detailed texts and the `AudioPlayerBar` widget.

3. **Audio Player Bar Widget (`audio_player_bar.dart`)**:
   - Create a clean visual player interface with play/pause and stop buttons, a progress slider, and duration text.
   - Use the Mayura Peacock and Rakta Red colors.

4. **Integration**:
   - Update `lib/app.dart` to load `CarouselScreen` as the home widget.

5. **Verification**:
   - Implement widget tests in `test/carousel_screen_test.dart` to verify carousel swiping, active page updates, and card flipping.
   - Verify `flutter analyze` and `flutter test` are clean.

---

## 3. Files to be changed

### New Files
- `lib/screens/carousel_screen.dart`
- `lib/widgets/flipping_card.dart`
- `lib/widgets/audio_player_bar.dart`
- `test/carousel_screen_test.dart`

### Modified Files
- `lib/app.dart`
- `docs/implementation_progress.md`

---

## 4. Verification Plan

- Run `flutter analyze` to verify the codebase has no lint errors.
- Run `flutter test` to verify all tests pass.

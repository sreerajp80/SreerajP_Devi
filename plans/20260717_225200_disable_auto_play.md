# Disable Mantra Auto Play When Card Is Flipped

**Status:** completed

## Issue
Currently, when a user flips a Durga card to see details, the mantra audio starts playing automatically. The user wants to disable this auto-play behavior. The mantra should only play when the user taps play on the audio controller.

## Proposed Changes
We will modify one file:
- `lib/widgets/flipping_card.dart`

In [flipping_card.dart](file:///L:/Android/SreerajP_Devi/lib/widgets/flipping_card.dart):
- Remove the line that calls `ref.read(audioServiceProvider).playMantra(widget.durga.audioPath);` inside the `flip()` method.
- Keep the line that stops the audio when the card is flipped back to the front side to clean up the playback.

## Verification Plan
### Automated Tests
- Run `flutter test` to ensure that all widget tests and unit tests still pass.

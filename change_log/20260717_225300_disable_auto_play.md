# Disable Mantra Auto Play When Card Is Flipped

We disabled the auto-play behavior of the mantra audio when the Durga card is flipped to the details side.

This change implements the plan: [plans/20260717_225200_disable_auto_play.md](../plans/20260717_225200_disable_auto_play.md)

## Changes
- Modified [lib/widgets/flipping_card.dart](../lib/widgets/flipping_card.dart):
  - Removed `ref.read(audioServiceProvider).playMantra(widget.durga.audioPath);` inside the `flip` method when the card is flipped to details.
  - Kept the cleanup logic `ref.read(audioServiceProvider).stopMantra();` when the card is flipped back to the front side.

## Verification
- Verified by running all unit/widget tests (`flutter test`), ensuring everything passes correctly.

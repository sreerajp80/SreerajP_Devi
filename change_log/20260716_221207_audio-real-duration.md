# Change log: Show real audio duration on player cards

Implements plan `plans/20260716_221010_audio-real-duration.md`.

## What was changed

The audio player bar on each card used to always show `0:30` as the total
duration until the clip was played, because the duration was hardcoded as a
30-second fallback and only corrected after playback started. Now the card
reads and shows the real clip length as soon as it is built.

### `lib/core/audio/audio_service.dart`
- Added a dedicated `_probePlayer` (`AudioPlayer`) used only for reading a
  clip's duration, so it never disturbs the active mantra playback.
- Added `Future<Duration?> getMantraDuration(String path)`: lazily creates the
  probe player, calls `setSource(AssetSource(...))` then `getDuration()`, and
  returns the result. Returns `null` in test mode or on error.
- Disposed `_probePlayer` in `dispose()` alongside the other players.

### `lib/widgets/audio_player_bar.dart`
- In `_initAudioSubscriptions()`, added a one-time call to
  `getMantraDuration(widget.audioPath)` that sets `_duration` to the real
  value when it returns a valid, non-zero duration.
- The 30-second value now acts only as a last-resort fallback; the existing
  `onDurationChanged` listener still confirms/updates the value during
  playback.

## Verification

- `flutter analyze` on both changed files: no issues.
- `flutter test` (audio_service, splash_screen, carousel_screen): all pass.
  In test mode `getMantraDuration` returns `null`, so the fallback path is
  used and existing tests are unaffected.

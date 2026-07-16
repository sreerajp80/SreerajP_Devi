# Show real audio duration on player cards

**Status:** completed

## The issue

Every card's audio player bar shows `0:30` as the total duration, even
though the actual mantra audio files are shorter (and vary in length).

Cause: in `lib/widgets/audio_player_bar.dart`, the state field `_duration`
is initialized to a hardcoded 30-second fallback:

```dart
Duration _duration = const Duration(seconds: 30); // reasonable fallback default
```

The real duration is only learned **after** the user presses play, when the
`onDurationChanged` stream fires. Before playback, the card just shows the
30-second guess. Because a card back is visible before it is ever played,
users always see the wrong `0:30`.

## The plan for the fix

Pre-load each clip's real duration when the player bar is built, without
starting playback. The `audioplayers` package (v6) can read a source's
duration using a probe player (`setSource(...)` then `getDuration()`), which
does not affect the shared mantra player used for actual playback.

1. **`lib/core/audio/audio_service.dart`**
   - Add a new method `Future<Duration?> getMantraDuration(String path)`.
   - It uses a dedicated, lazily-created probe `AudioPlayer` (separate from
     `_mantraPlayer` and `_sfxPlayer`, so it never interferes with real
     playback).
   - It calls `setSource(AssetSource(cleanPath))`, then `getDuration()`, and
     returns the result (or `null` on error / in test mode).
   - Dispose the probe player in `dispose()` alongside the other players.

2. **`lib/widgets/audio_player_bar.dart`**
   - Keep the 30s value only as a last-resort fallback.
   - In `_initAudioSubscriptions()` (or a small helper called from there),
     call `audioService.getMantraDuration(widget.audioPath)` once and, if it
     returns a valid non-zero duration, `setState` `_duration` to it.
   - The existing `onDurationChanged` listener stays as-is, so the value is
     still corrected/confirmed once playback begins.

## Files to be changed

- `lib/core/audio/audio_service.dart` — add `getMantraDuration()` probe method
  and dispose the probe player.
- `lib/widgets/audio_player_bar.dart` — fetch and display the real duration on
  build instead of always showing the 30s fallback.

## Testing

- `flutter analyze` — no new issues.
- `flutter test` — existing audio/widget tests still pass (probe method
  returns null in test mode, so the fallback path is exercised).
- Manual: open a card, confirm the total duration shown matches the actual
  audio length before pressing play.

## Notes / risks

- Probing 9 short asset files is cheap and happens only when a bar is built.
- In test mode (`FLUTTER_TEST`), `getMantraDuration` returns `null`, so the
  widget keeps its current fallback behaviour and existing tests are
  unaffected.

# Plan - Phase 5: Clean Audio Service Lifecycle

**Status:** completed

This plan implements Phase 5 of the Devi (Navadurga) project. It integrates an `AppLifecycleListener` inside the `AudioService` to manage the audio playback lifecycle state when the application is backgrounded or minimized.

---

## 1. What the issue is

The application must follow strict audio lifecycle rules. Currently, if the user starts a mantra audio playback and minimizes the app (or puts it in the background), the audio continues to play.
We must ensure that:
- Leaving the app or putting it in the background must stop or pause audio playback to save system resources and respect the user's focus.

---

## 2. Plan for the fix

1. **Modify `AudioService` (`lib/core/audio/audio_service.dart`)**:
   - Register `AppLifecycleListener` inside the constructor.
   - Implement handlers for `onPause` and `onInactive` that call `pauseMantra()` and stop the SFX player.
   - Maintain a `lastLifecycleState` field to facilitate testing.
   - Dispose of `AppLifecycleListener` in the `dispose` method.
   
2. **Modify `AudioService` Tests (`test/audio_service_test.dart`)**:
   - Add a unit test to simulate `AppLifecycleState` changes using `ServicesBinding.instance.handleAppLifecycleStateChanged` or `WidgetsBinding.instance.handleAppLifecycleStateChanged`.
   - Verify that the listener is registered and captures the states correctly.

---

## 3. Files to be changed

### Modified Files
- [audio_service.dart](file:///l:/Android/SreerajP_Devi/lib/core/audio/audio_service.dart)
- [audio_service_test.dart](file:///l:/Android/SreerajP_Devi/test/audio_service_test.dart)

---

## 4. Verification Plan

- Run `flutter analyze` to ensure zero compilation or lint issues.
- Run `flutter test` to ensure that all tests, including the new lifecycle tests, pass successfully.

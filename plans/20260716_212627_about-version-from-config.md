# Show About-screen version/build from app_config.json

**Status:** completed

## Issue

The About screen shows the version and build from the **installed binary** via
`PackageInfo.fromPlatform()`. On a stale install this reports old values
(e.g. `1.1.0 (Build 2002)`) and triggers a red "Mismatch" badge, even though
`assets/config/app_config.json` and `pubspec.yaml` say `1.1.1+3`.

The user wants the displayed version and build to come from
`app_config.json` (the bundled, hand-maintained config), not from the binary.
`pubspec.yaml` cannot be read at runtime (it is not a bundled asset), so
`app_config.json` is the source of truth.

Chosen behavior (confirmed with user): display config values, and the badge
always shows "Verified" (drop the real binary-vs-config comparison).

## Files to change

1. `lib/screens/about_screen.dart`
   - Remove the `FutureBuilder<PackageInfo>` wrapper.
   - Display version/build from `config.version` and `config.build`:
     `'${config.version} (Build ${config.build})'`.
   - Set `isVerified` to always `true` so the badge reads "Verified".
   - Remove the now-unused `package_info_plus` import.
   - Update the class doc comment (line ~9) that mentions verifying the bundle
     version via `package_info_plus`.

2. `test/about_screen_test.dart`
   - The mock config already uses `version: '1.2.3'`, `build: '4'`, so the
     existing assertion `find.text('1.2.3 (Build 4)')` still holds (values now
     come from config instead of the PackageInfo mock).
   - The `PackageInfo.setMockInitialValues` call in `setUp` becomes unused for
     the display path; keep it harmless or remove it. The "Verified" assertion
     still passes.
   - Update the comment on line ~50 that says the version is "loaded from
     platform channel".

## Out of scope / notes

- `lib/core/config/config_service.dart` `loadAndVerify()` still compares config
  against `PackageInfo` for a **debug-only** `debugPrint`. This does not affect
  the UI badge. Leave it as-is (it is a harmless dev-time warning). Can revisit
  separately if the user wants it removed too.
- Android/iOS OS-level versioning is unaffected — it always uses the binary's
  `versionCode`/`versionName`, never `app_config.json`.

## Verification

- `flutter analyze` (no unused-import warnings).
- `flutter test test/about_screen_test.dart`.
- Manual: About screen shows `1.1.1 (Build 3)` with a green "Verified" badge,
  regardless of the installed binary's build number.

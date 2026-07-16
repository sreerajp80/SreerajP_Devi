# Change log: About-screen version/build from app_config.json

Implements plan `plans/20260716_212627_about-version-from-config.md`.

## What changed

The About screen now shows the version and build from the bundled
`assets/config/app_config.json` instead of from the installed binary
(`PackageInfo.fromPlatform()`). This removes the stale "Build 2002" style
reading that came from an older installed APK, and the badge always shows
"Verified".

## Files changed

1. `lib/screens/about_screen.dart`
   - Removed the `FutureBuilder<PackageInfo>` wrapper and the
     `package_info_plus` import.
   - Version/build label now built from `config.version` / `config.build`:
     `'${config.version} (Build ${config.build})'` (local variable renamed from
     `platformVersion` to `versionLabel`).
   - `isVerified` is now a constant `true`, so the badge always reads
     "Verified".
   - Updated the class doc comment to drop the `package_info_plus` mention.

2. `test/about_screen_test.dart`
   - Removed the now-unused `PackageInfo.setMockInitialValues` `setUp` block and
     the `package_info_plus` import.
   - Renamed the first test and updated the version comment to say the value
     comes from `app_config.json`. The `1.2.3 (Build 4)` and "Verified"
     assertions still hold (mock config already used those values).

## Not changed

- `lib/core/config/config_service.dart` `loadAndVerify()` still does a
  debug-only `debugPrint` comparing config against `PackageInfo`. It does not
  affect the UI badge and was left as-is.

## Verification

- `flutter analyze lib/screens/about_screen.dart test/about_screen_test.dart`
  — No issues found.
- `flutter test test/about_screen_test.dart` — All tests passed.

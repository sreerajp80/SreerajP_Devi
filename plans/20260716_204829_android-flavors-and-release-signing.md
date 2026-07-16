# Android Build Flavors + Release Signing Setup

**Status:** completed

## The Issue

The build command `flutter build ... --flavor prod` (and `flutter run --flavor prod`)
fails with:

```
Task 'assembleProdRelease' not found in root project 'android'.
[!] The build.gradle.kts file does not define any custom product flavors.
    You cannot use the --flavor option.
```

Root cause: [android/app/build.gradle.kts](../android/app/build.gradle.kts) defines
**no product flavors**, but the project guidelines
([flutter_build_flavors_guide.md](../docs/guidelines/flutter_build_flavors_guide.md),
[release_process.md](../docs/guidelines/release_process.md)) expect `dev` and `prod`
flavors. There is also **no release signing config** — the release build type is signed
with the debug key (line 37), which is not allowed for a real release.

## Decisions (confirmed with user)

- **Keystore:** Wire the Gradle config + a `key.properties.example` template + a build
  guard only. No real keystore or secrets are created now. The user generates the
  keystore and fills in `android/key.properties` later, before the first store build.
- **Minification:** Enable R8/ProGuard (`isMinifyEnabled = true`) with keep rules.

## Files To Change / Create

1. **`android/app/build.gradle.kts`** (edit) — the main change:
   - Load `android/key.properties` if present (Strategy A, local file-based signing).
   - Add a `release` `signingConfig` that reads keystore credentials from that file.
   - Add `flavorDimensions += "environment"` with `dev` and `prod` product flavors:
     - `dev`: `applicationIdSuffix = ".dev"`, `versionNameSuffix = "-dev"`,
       `resValue("string", "app_name", "Devi Dev")`.
     - `prod`: `resValue("string", "app_name", "Devi")`.
   - In `buildTypes.release`: enable `isMinifyEnabled = true`, add `proguardFiles(...)`,
     and use the `release` signing config only when `key.properties` exists (so
     `flutter run --release` still works via debug key until a keystore is added).
   - Add an `afterEvaluate` guard that fails `assembleProdRelease` / `bundleProdRelease`
     with a clear message when `android/key.properties` is missing.

2. **`android/app/proguard-rules.pro`** (create) — keep rules for the Flutter engine
   (`io.flutter.**`, `io.flutter.plugins.**`). No native plugins are in use yet, so no
   extra keeps; a comment notes where to add them.

3. **`android/app/src/main/AndroidManifest.xml`** (edit) — change the hardcoded
   `android:label="sreerajp_devi"` to `android:label="@string/app_name"` so the flavor's
   `app_name` resource is used (Devi / Devi Dev). The icon stays `@mipmap/ic_launcher`.

4. **`android/key.properties.example`** (create) — a committed template showing the four
   required keys (`storeFile`, `storePassword`, `keyAlias`, `keyPassword`) with
   placeholder values, so the user knows exactly what to fill in. The real
   `android/key.properties` stays gitignored.

5. **`CLAUDE.md`** (edit) — update the Build & Run commands. Once flavors exist, a bare
   `flutter run` fails with "you must specify a flavor". Update to:
   - Run: `flutter run --flavor dev`
   - Build APK (prod release): the full hardened command from the release guide
     (`--flavor prod --release --obfuscate --split-debug-info=... --split-per-abi`).

## What This Does NOT Do

- Does **not** create a real keystore or any secret material.
- Does **not** add a Dart `AppFlavorConfig` (the guide references one, but it is optional
  and not needed to fix the build; can be a follow-up if you want runtime flavor logic).
- Does **not** touch iOS or Windows flavor setup (Android-only, per the reported failure).
- `.gitignore` already covers `android/key.properties`, `*.jks`, `*.keystore` — no change
  needed there.

## Verification

- `cd android && ./gradlew tasks --all | grep -i release` — confirm `assembleDevRelease`,
  `assembleProdRelease`, `bundleProdRelease` now exist.
- `flutter run --flavor dev` — dev flavor builds and runs (debug key, no setup).
- `flutter build apk --flavor prod --release` **without** `key.properties` — should fail
  with the clear "SIGNING REQUIRED" guard message (proves the guard works).
- `flutter analyze` — no new issues.

## Post-Change

Write a change log under `change_log/` referencing this plan.

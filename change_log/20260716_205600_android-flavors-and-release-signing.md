# Change Log: Android Build Flavors + Release Signing

Implements plan
[plans/20260716_204829_android-flavors-and-release-signing.md](../plans/20260716_204829_android-flavors-and-release-signing.md).

## Why

`flutter build/run --flavor prod` failed with `Task 'assembleProdRelease' not found`
because `android/app/build.gradle.kts` defined no product flavors. Release builds were
also signed with the debug key. Both are now fixed.

## Changes

- **`android/app/build.gradle.kts`**
  - Added `import java.util.Properties` (the Gradle Kotlin DSL `java` accessor shadows the
    `java.util` package, so a fully-qualified `java.util.Properties()` fails to compile).
  - Loads `android/key.properties` when present (Strategy A, local file-based signing).
  - Added a `release` `signingConfig` reading keystore credentials from that file.
    `storeFile` is resolved via `rootProject.file(...)`, i.e. relative to `android/`.
  - Added `flavorDimensions += "environment"` with `dev` and `prod` flavors:
    - `dev`: `applicationIdSuffix = ".dev"`, `versionNameSuffix = "-dev"`,
      `app_name = "Devi Dev"`.
    - `prod`: `app_name = "Devi"`.
  - `buildTypes.release`: enabled `isMinifyEnabled = true` and `isShrinkResources = true`
    with `proguard-rules.pro`; uses the release signing config only when `key.properties`
    exists, otherwise falls back to the debug key (so `flutter run --release` still works).
  - Added an `afterEvaluate` guard that fails `assembleProdRelease` / `bundleProdRelease`
    with a clear "SIGNING REQUIRED" message when `android/key.properties` is missing.

- **`android/app/proguard-rules.pro`** (new) — keep rules for the Flutter engine
  (`io.flutter.**`, `io.flutter.plugins.**`); comment shows where to add native-plugin
  keeps later.

- **`android/app/src/main/AndroidManifest.xml`** — `android:label` changed from the
  hardcoded `sreerajp_devi` to `@string/app_name` so each flavor shows its own name.

- **`android/key.properties.example`** (new) — committed template for the four signing
  keys plus the `keytool` command to create the keystore. The real
  `android/key.properties` stays gitignored (already covered by `.gitignore`).

- **`CLAUDE.md`** — updated Build & Run commands: `flutter run` now requires `--flavor`
  (`dev`/`prod`); added the hardened prod release APK and Play Store bundle commands.

## Verification

- `./gradlew :app:tasks --all` — the config compiles (only a pre-existing `jvmTarget`
  deprecation warning) and `assembleProdRelease`, `bundleProdRelease`, `assembleDevRelease`
  and the matching install/uninstall variants are now registered. The original missing
  task now exists.
- Not run end-to-end here (slow full build): a real `flutter build apk --flavor prod
  --release` without `key.properties` to see the guard message, and `flutter run
  --flavor dev` on a device. The guard logic and signing fallback follow the vetted
  pattern in the flavors guide.

## Follow-ups (not done)

- Generate the real keystore and create `android/key.properties` before the first store
  build (see `android/key.properties.example`).
- Optional Dart `AppFlavorConfig` for runtime flavor logic (referenced by the guide, not
  required for the build).
- iOS / Windows flavor setup (Android-only change, per the reported failure).

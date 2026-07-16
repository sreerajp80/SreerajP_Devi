# Fix prod release build failures (R8 Play Core + Kotlin cross-drive cache)

**Status:** completed

## What the issue is

A `flutter build ... --flavor prod --release` failed with two separate problems in
the log:

1. **R8 hard error (build-breaker).** R8 reports many missing classes such as
   `com.google.android.play.core.splitcompat.SplitCompatApplication`,
   `...splitinstall.SplitInstallManager`, `...tasks.OnSuccessListener`, etc. These
   are referenced from Flutter's own embedding classes
   (`io.flutter.embedding.engine.deferredcomponents.*`,
   `io.flutter.embedding.android.FlutterPlayStoreSplitApplication`). The app keeps
   all of `io.flutter.**` in `proguard-rules.pro`, so those kept classes drag in
   references to the Google Play Core library, which is **not** a dependency of this
   app (it does not use deferred components). In R8 full mode, a kept class that
   references a missing class is a fatal error, so the build stops.

2. **Kotlin daemon incremental-cache crash (environmental noise, possibly fatal).**
   Stack traces show
   `IllegalArgumentException: this and base files have different roots:
   H:\Flutter\Pub\Cache\... and L:\Android\SreerajP_Devi\android`.
   The Flutter pub cache lives on drive **H:** while the project is on drive **L:**.
   Kotlin's incremental compiler (`RelocatableFileToPathConverter`) tries to make a
   file path relative across two different Windows drive roots, which is impossible,
   so it throws while closing its incremental caches ("Could not close incremental
   caches ..."). This corrupts the Kotlin incremental build for plugins like
   `package_info_plus` and `audioplayers_android`.

## Files to be changed

1. `android/app/proguard-rules.pro` — add keep/dontwarn rules for Google Play Core.
2. `android/gradle.properties` — disable Kotlin incremental compilation to avoid the
   cross-drive cache crash.

## The plan for the fix

### Fix 1 — R8 missing Play Core classes
Add these lines to `android/app/proguard-rules.pro`:

```
# Flutter's embedding references Google Play Core (deferred components / split
# installs). This app does not use deferred components and does not ship Play Core,
# so tell R8 to ignore the missing references instead of failing the build.
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }
```

This is the officially documented Flutter fix for this exact R8 error. It does not
add any dependency; it only stops R8 from treating the absent Play Core classes as an
error.

### Fix 2 — Kotlin cross-drive incremental cache crash
Add to `android/gradle.properties`:

```
# Pub cache and project can live on different Windows drives (e.g. H: vs L:).
# Kotlin's incremental compiler cannot relativize paths across drive roots and
# crashes while closing its caches. Disabling incremental Kotlin compilation avoids
# that buggy code path. Full (non-incremental) compilation is unaffected.
kotlin.incremental=false
```

Alternative (not part of this plan, noted for the user): set the `PUB_CACHE`
environment variable to a folder on the **L:** drive and run `flutter pub get` again,
so the pub cache and project share one drive root. That also fixes it but changes the
developer's global environment, so the gradle.properties change is preferred as a
repo-local fix.

## Verification

After the changes:
- Run the prod release build command from `CLAUDE.md`:
  `flutter build apk --flavor prod --release --obfuscate --split-debug-info=build/symbols/android-prod-<version>/ --split-per-abi`
- Confirm R8 no longer reports missing Play Core classes and the build completes.
- Optionally run `flutter clean` first to clear the corrupted Kotlin caches under
  `build/`.

## Rollback

Both changes are additive and isolated to two build-config files. Reverting the two
edits restores the previous behaviour.

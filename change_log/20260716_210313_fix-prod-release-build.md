# Change log — Fix prod release build failures

**Implements plan:** `plans/20260716_210313_fix-prod-release-build.md`
**Date:** 2026-07-16

## What was changed

### 1. `android/app/proguard-rules.pro`
Added R8 keep/dontwarn rules for Google Play Core:

```
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }
```

**Why:** The release build failed with `ERROR: Missing class
com.google.android.play.core.splitcompat.SplitCompatApplication` (and several other
`com.google.android.play.core.*` classes). These are referenced by Flutter's own
embedding (`io.flutter.embedding.engine.deferredcomponents.*`,
`FlutterPlayStoreSplitApplication`), which the app keeps via `-keep class
io.flutter.** { *; }`. The app does not use deferred components and does not ship the
Play Core library, so R8 full mode treated the missing references as a fatal error.
The `-dontwarn` rule tells R8 to ignore them. No new dependency was added.

### 2. `android/gradle.properties`
Added:

```
kotlin.incremental=false
```

**Why:** The build log showed repeated Kotlin daemon crashes:
`IllegalArgumentException: this and base files have different roots:
H:\Flutter\Pub\Cache\... and L:\Android\SreerajP_Devi\android`. The pub cache is on
drive H: and the project is on drive L:; Kotlin's incremental compiler cannot make a
relative path across two Windows drive roots and crashes while closing its caches.
Disabling incremental Kotlin compilation avoids that code path.

## Verification / next steps

Not yet re-run by me. Recommended:
1. `flutter clean` (clears the corrupted Kotlin caches under `build/`).
2. `flutter build apk --flavor prod --release --obfuscate --split-debug-info=build/symbols/android-prod-<version>/ --split-per-abi`
3. Confirm R8 no longer reports missing Play Core classes and the build completes.

## Rollback

Revert the two edits above; both are additive and isolated to build-config files.

# ProGuard / R8 keep rules for release builds.
# R8 full mode is the default on AGP 8.x. It can strip classes that are only
# reached via reflection or from native code, causing ClassNotFoundException /
# NoSuchMethodException that appear ONLY in release builds.

# Flutter engine and generated plugin registrant - always required.
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Flutter's embedding references Google Play Core (deferred components / split
# installs) from io.flutter.embedding.engine.deferredcomponents.* and
# FlutterPlayStoreSplitApplication. This app does not use deferred components and does
# not ship Play Core, so tell R8 to ignore the missing references instead of failing
# the release build with "Missing class com.google.android.play.core.*".
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }

# Add keep rules here for any native Android plugin package (Java/Kotlin) that
# documents reflection-based class loading in its README. There are none in use
# yet. Do not add blanket rules - check each package's documentation first.
# Example (sqflite, if added later):
# -keep class com.tekartik.sqflite.** { *; }

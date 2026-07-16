import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// ─── Signing ─────────────────────────────────────────────────────────────────
// Strategy A (local file-based signing). Credentials are read from
// android/key.properties, which is gitignored. See key.properties.example for the
// required keys, and docs/guidelines/flutter_build_flavors_guide.md for the full
// rationale. The file is intentionally absent from source control.
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties().apply {
    if (keystorePropertiesFile.exists()) {
        load(keystorePropertiesFile.inputStream())
    }
}

android {
    namespace = "in.sreerajp.sreerajp_devi"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "in.sreerajp.sreerajp_devi"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            // Only wired up when key.properties is present. Until then, the release
            // build type falls back to the debug key (see buildTypes.release below).
            if (keystorePropertiesFile.exists()) {
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
                // storeFile is relative to android/ (rootProject), where the .jks lives.
                storeFile = keystoreProperties.getProperty("storeFile")?.let { rootProject.file(it) }
                storePassword = keystoreProperties.getProperty("storePassword")
            }
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            // Use the release keystore when configured; otherwise fall back to the
            // debug key so `flutter run --release` still works during development.
            signingConfig = if (keystorePropertiesFile.exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
        debug {
            // Android applies the SDK debug keystore automatically.
        }
    }

    flavorDimensions += "environment"
    productFlavors {
        create("dev") {
            dimension = "environment"
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
            resValue("string", "app_name", "Devi Dev")
        }
        create("prod") {
            dimension = "environment"
            resValue("string", "app_name", "Devi")
        }
    }
}

flutter {
    source = "../.."
}

// ─── Signing enforcement ──────────────────────────────────────────────────────
// Block prod --release builds when key.properties is absent, instead of silently
// signing with the debug key. Dev builds and all debug builds are unaffected.
afterEvaluate {
    listOf("assembleProdRelease", "bundleProdRelease").forEach { taskName ->
        tasks.findByName(taskName)?.doFirst {
            if (!keystorePropertiesFile.exists()) {
                throw GradleException(
                    "\n" +
                    "==========================================================\n" +
                    "  SIGNING REQUIRED - prod --release build blocked         \n" +
                    "==========================================================\n" +
                    "  android/key.properties not found.                       \n" +
                    "  Create it from android/key.properties.example with your  \n" +
                    "  release keystore credentials, and place the .jks file    \n" +
                    "  in android/.                                             \n" +
                    "  See docs/guidelines/flutter_build_flavors_guide.md       \n" +
                    "  Section: Android Signing Configuration                   \n" +
                    "==========================================================\n"
                )
            }
        }
    }
}

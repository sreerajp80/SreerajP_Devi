# Devi (Navadurga) Project Implementation Plan

This document outlines the detailed implementation plan for the Devi (Navadurga) Flutter application. The design is offline-first, lock-oriented (portrait only), has a devotional dark/warm palette, and utilizes high-performance 3D flip card and Pushpanjali (flower offering) animations.

---

## 1. Phase 1: Core Foundation & UI Setup
- **Objective**: Initialize the Flutter project, establish folders, register packages, and set up the theme and constants.
- **Action Steps**:
  1. Initialize the Flutter app using `flutter create --org in.sreerajp --project-name sreerajp_devi .` in the root workspace.
  2. Modify `pubspec.yaml` to configure open-source dependencies:
     - `flutter_riverpod` (state management)
     - `audioplayers` (audio playback)
     - `package_info_plus` (version display in About screen)
     - `google_fonts` (to load fonts, or configure offline local fonts in assets)
  3. Set up directory structures:
     - `lib/core/config/`, `lib/core/constants/`, `lib/core/theme/`, `lib/core/audio/`
     - `lib/models/`, `lib/repositories/`
     - `lib/screens/`, `lib/widgets/`
  4. Implement `lib/core/constants/app_colors.dart` with locked colors:
     - Rakta Red: `#8B0000`
     - Swarna Gold: `#D4AF37`
     - Haridra/Ghee Background: `#FDF6E2`
     - Mayura Peacock Accent: `#0F5257`
  5. Implement `lib/core/theme/app_theme.dart` applying these colors to Material 3 widgets.

---

## 2. Phase 2: Assets & Static Data Integration
- **Objective**: Load configurations and static Malayalam content locally. No external APIs or server dependencies (offline-first).
- **Action Steps**:
  1. Create `assets/config/app_config.json` containing the application metadata.
  2. Create `assets/data/navadurga_data.json` containing detailed records for the Nine Durgas:
     - `id`: 1 to 9
     - `nameEnglish`, `nameSanskrit`, `nameMalayalam`
     - `mantraSanskrit` (Devanagari)
     - `mantraMalayalam` (Malayalam script/translation)
     - `descriptionMalayalam` (Malayalam significance description)
     - `imagePath` and `audioPath`
  3. Load locally-packaged images (`assets/images/durgas/`, `assets/images/ui/`) and audio files (`assets/audio/mantras/`, `assets/audio/sfx/`).
  4. Implement Dart data models:
     - `lib/models/durga_model.dart`
     - `lib/core/config/app_config.dart`
  5. Implement repository and configuration loader services:
     - `lib/repositories/durga_repository.dart`
     - `lib/core/config/config_service.dart`

---

## 3. Phase 3: Carousel Navigation & 3D Flipping Card
- **Objective**: Implement the horizontal swiping layout and Y-axis rotating cards.
- **Action Steps**:
  1. Create `lib/screens/carousel_screen.dart` with a centered `PageView` displaying the Durga cards.
  2. Add scale and opacity transitions in the carousel so adjacent cards are slightly smaller and dimmer, highlighting the active card.
  3. Create `lib/widgets/flipping_card.dart` using Flutter's `GestureDetector`, `Transform` matrix, and `AnimationController` for a smooth Y-axis 180-degree rotation.
  4. Render the Durga portrait on the front of the card and details on the back (English/Sanskrit/Malayalam names, Sanskrit Mantra, Malayalam translation/description, and playback controls).

---

## 4. Phase 4: Pushpanjali (Lotus Offering) Animation
- **Objective**: Enable the flower rising gesture that triggers the card flip and chant.
- **Action Steps**:
  1. Create `lib/widgets/pushpanjali_offering.dart` which renders a floating Rakta Kamala (Lotus) button at the bottom of the screen.
  2. Implement an animation where a tap on the button spawns a red lotus graphic rising smoothly, scaling down, and coming to rest on the Durga's pedestal (feet area) at the bottom of the card.
  3. Coordinate animations: upon lotus arrival at the pedestal, play temple bell sound effect (`assets/audio/sfx/chime.mp3`), start Y-axis flip transition, and trigger audio service.

---

## 5. Phase 5: Clean Audio Service Lifecycle
- **Objective**: Build a robust, offline audio system with strict lifecycle control to prevent overlapping sounds.
- **Action Steps**:
  1. Create `lib/core/audio/audio_service.dart` wrapping `audioplayers` as a singleton/provider.
  2. Implement strict lifecycle methods:
     - `playMantra(String path)`: Stop any active sound, then load and play the selected mantra.
     - `stop()`: Stop playback.
     - `pause()` / `resume()`: Local card controls.
  3. Connect swiping events: call `stop()` on page swipe start to terminate active playback immediately.
  4. Handle application lifecycles using `AppLifecycleListener` or `WidgetsBindingObserver` to pause/stop audio when the app is backgrounded.

---

## 6. Phase 6: Splash Screen & About Page
- **Objective**: Build the launch chime/bloom animation and the verified metadata-driven about page.
- **Action Steps**:
  1. Create `lib/screens/splash_screen.dart` featuring a vector/image of a lotus bud that smoothly rotates and scales outwards to full bloom over 1.5 seconds.
  2. Simultaneously play `assets/audio/sfx/chime.mp3` or a custom shankha sound.
  3. Build `lib/screens/about_screen.dart` conforming to design guidelines, displaying information loaded from `app_config.json` via `ConfigService` (using `package_info_plus` to verify bundle matches).

---

## 7. Verification & Definition of Done
- **Verification steps**:
  - Run `flutter analyze` and ensure zero errors or warnings.
  - Implement widget tests for:
    - Carousel page changes.
    - Card flip rendering.
    - Config loader decoding.
  - Verify audio stops when swiping or backgrounding.
  - Ensure correct rendering of Malayalam ligatures and scalable text fonts.

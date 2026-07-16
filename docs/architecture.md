# Architecture — SreerajP_Devi

Technical design for the Flutter Android app showcasing the Nine Durgas (Navadurga) with interactive Pushpanjali (floral offering), page-flipping animations, and audio playbacks. This document explains how the app is structured, which open-source packages to use, and how the core features fit together.

Read [.agents/AGENTS.md](../.agents/AGENTS.md) first for the project rules. See [SreerajP_Devi_Idea.md](SreerajP_Devi_Idea.md) for the product idea and requirements.

---

## 1. Project Configuration

*   **Project Name:** `sreerajp_devi`
*   **Application ID / Android Package Name:** `in.sreerajp.devi`
*   **Target Platform:** Android (minSdk 21, portrait only)

---

## 2. Design Goals

- **Sacred, Immersive UI**: Adaptive layout with transitions that feel spiritual, using the warm, traditional color palette of Bala Tripurasundari wallpaper.
- **Micro-Animations**: A 3D flipping card animation and a blooming lotus launch screen running at 60fps.
- **Clean Audio Lifecycles**: Strict playback isolation (no overlapping mantras; playback stops on page swipe).
- **Offline-Only**: Fully packaged local asset dependency for images, audio, and texts.
- **Strict Guidelines Adherence**: Adhere to the single source of truth configuration pattern for the About screen.

---

## 3. Layered Architecture

```
+------------------------------------------------------------------+
| UI Layer (screens + widgets, Material 3)                          |
|   BloomingSplash, NavadurgaCarousel, FlippingCard, AboutScreen    |
+------------------------------------------------------------------+
| State Layer (Riverpod providers or simple ChangeNotifier)        |
|   Orchestrates audio service, page indicators, and active state   |
+------------------------------------------------------------------+
| Core + Services (pure Dart, testable)                            |
|   AudioService, ConfigService, NavadurgaRepository               |
+------------------------------------------------------------------+
| Data / Asset Layer                                               |
|   app_config.json, navadurga_data.json, local images, audio      |
+------------------------------------------------------------------+
```

---

## 4. Recommended Open-Source Packages

All packages must be open-source and conform to the project guidelines.

| Concern | Package (open source) |
|---|---|
| State Management | `flutter_riverpod` or simple `provider` |
| Audio Playback | `audioplayers` or `just_audio` |
| App info / version | `package_info_plus` (required for About screen verification) |
| Fonts | Bundled local fonts or `google_fonts` configured offline |

---

## 5. Project Folder Structure

Follows the guidelines in `guideline.md` with extensions for assets:

```
lib/
  main.dart
  app.dart                      # MaterialApp setup with theme configurations
  
  core/
    config/
      app_config.dart           # typed model of assets/config/app_config.json
      config_service.dart       # asset loader
    constants/
      app_colors.dart           # Swarna Gold, Rakta Red, Haridra Ghee, Mayura Accent
      app_constants.dart        # asset paths, fonts
    theme/
      app_theme.dart            # custom Material 3 theme definitions
    audio/
      audio_service.dart        # manages play, stop, active-track tracking
      
  models/
    durga_model.dart            # model representing a single Durga (name, mantra, desc, etc.)
    
  repositories/
    durga_repository.dart       # loads durga data from JSON asset
    
  screens/
    splash_screen.dart          # Blooming Lotus launch experience
    carousel_screen.dart        # Main Navadurga carousel with PageView
    about_screen.dart           # Config-driven About screen (complying with guideline.md)
    
  widgets/
    flipping_card.dart          # 3D flip card component
    pushpanjali_offering.dart   # micro-interaction flower offering animation
    audio_player_bar.dart       # localized audio controls for the back of the card

assets/
  config/
    app_config.json             # App version metadata (About screen source of truth)
  data/
    navadurga_data.json         # containing the list of 9 Durgas, Sanskrit/Malayalam mantras, descriptions
  images/
    durgas/                     # 9 high-quality Durga portrait images
    ui/                         # red lotus icons, backgrounds, splash elements
  audio/
    mantras/                    # 9 mantra audio files
    sfx/                        # temple bell chime, shankha sound
```

---

## 6. UI Theme & Visual Aesthetic

- **Theme**: Warm and sacred colors extracted from the Bala Tripurasundari wallpaper.
  - Primary (Blood Red / Rakta): `#8B0000`
  - Secondary (Golden / Swarna): `#D4AF37`
  - Background (Warm Turmeric / Haridra): `#FDF6E2`
  - Accent (Peacock Blue/Green / Mayura): `#0F5257`
- **Typography**: Traditional serif headings paired with clean, highly readable Malayalam body fonts (e.g., Google Font `Manjari` or `Gayathri`).
- **Icons**: Customized lotus vector icons for buttons and active markers.

---

## 7. Key Interactions

### Blooming Splash
On opening the app, a vector/image of a lotus bud sits at the center. It smoothly scales and rotates/blooms outwards over 1.5 seconds. A `chime.mp3` audio effect plays simultaneously. Once completed, the screen fades into the main carousel.

### Horizontal Carousel
A `PageView` with smooth transitions is used to swipe between the 9 Durgas. To prevent visual clutter, only the active card is fully highlighted, while the left/right cards are slightly scaled down and dimmed.

### Pushpanjali Offering & 3D Card Flip
Each page displays the front side of the card (the Durga portrait with a pedestal at the bottom). A floating red lotus button invites the user to perform Pushpanjali.
1. When tapped, a lotus vector rises smoothly from the button towards the feet of the portrait, scaling down as if placed there.
2. Upon reaching the feet, a soft chime is heard, and the card undergoes a 3D horizontal rotation (flip animation) around its Y-axis.
3. The back of the card is revealed, presenting the texts, and the specific mantra audio immediately starts playing.
4. Users can tap the card again to flip it back to the portrait, which pauses the audio.

---

## 8. Audio Lifecycle
- The `AudioService` class implements a singleton wrapper for the audio player.
- Whenever a mantra audio starts playing, any previously running audio is immediately stopped (`audioPlayer.stop()`).
- Listening to `PageController` scroll events: if a user starts swiping to a new page, `AudioService` is called to stop the current playback. This ensures a clean, non-overlapping auditory experience.
- App state lifecycle: `AppLifecycleListener` is registered to pause/stop audio when the app is minimized.

---

## 9. Non-Functional Requirements
- **Performance**: High frame rate (60fps) animations for the 3D card flip and Pushpanjali gesture.
- **Offline Reliability**: All static contents must load directly from `assets/`.
- **Malayalam Ligatures**: Malayalam strings must be loaded from JSON using proper UTF-8 decoding to ensure fonts render cleanly.
- **Graceful Failure**: If audio assets or fonts are missing, the layout must load with default system options and display error messages gracefully without throwing unhandled exceptions.

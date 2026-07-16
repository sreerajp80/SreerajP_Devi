# Devi (Navadurga) Flutter App - Conceptual Design

This document details the core concept, design system, and feature requirements for the Devi App.

## 1. Core Concept & Home Screen Placement
The app is designed to integrate intimately with the user's home screen wallpaper, which depicts **Bala Tripurasundari** with a **Sri Yantra** at the bottom.

### Charan-Pushpa (The Foot-Lotus Offering)
*   **The App Icon**: A stylized **Rakta Kamala** (Blood-Red Lotus).
*   **Placement**: The icon is intended to be placed directly at the feet portion of the Devi (resting on her white lotus pedestal, above the Sri Yantra).
*   **Symbolic Meaning**: In Shakta tradition, placing a red lotus at the feet of the Divine Mother (Devi Charanam) represents surrender (*Sharanagati*), pushpanjali (flower offering), and a gateway to spiritual focus.

---

## 2. Launch & Transition Experience
Tapping the icon triggers a sacred, immersive transition from the home screen into the app:
1.  **Blooming Splash**: The app opens to a splash screen where a closed lotus bud blooms into a full Rakta Kamala.
2.  **Sacred Audio**: A subtle, clear sound of a temple bell (`chime.mp3`) or shell-horn (`shankha`) plays briefly to mark the transition.
3.  **Color Morph**: The background transitions smoothly using the primary color palette extracted from the wallpaper.

---

## 3. Design System & Aesthetics
*   **Color Palette**:
    *   **Primary (Blood Red)**: `#8B0000` (Rakta) - representing the lotus, energy, and the Goddess.
    *   **Secondary (Temple Gold)**: `#D4AF37` (Swarna) - representing ornaments, halo, and borders.
    *   **Background (Warm Turmeric/Ghee)**: `#FDF6E2` (Haridra/Deepa) - a soft, warm background that mimics a sanctum lit by oil lamps.
    *   **Accents (Peacock Blue/Green)**: `#0F5257` (Mayura) - representing the peacock feathers in the wallpaper.
*   **Typography**:
    *   Headings: Traditional serif font (e.g., `Yatra One` or `Cinzel`).
    *   Malayalam texts: Clear, legible Malayalam font (e.g., `Gayathri` or `Manjari`).
*   **Visual Assets**: High-quality classic/traditional paintings of the Nine Durgas (Navadurga) to match the vintage/classical look of the home screen wallpaper.

---

## 4. In-App Experience & Navigation
The app consists of nine scrollable screens, one for each form of Navadurga.

### Navadurga Carousel
*   **Horizontal Swiping**: Users can swipe left or right to move between the nine pages (representing the 9 days/forms).
*   **Page Layout**:
    *   Each page features a beautiful portrait of the corresponding Durga.
    *   At the bottom of the portrait is a small representation of her feet/pedestal.
*   **Pushpanjali Interaction (The Card Flip)**:
    *   Users can perform a **Pushpanjali** (flower offering) by tapping a floating red lotus button, which animates the flower rising to the feet of the Durga.
    *   Upon offering:
        1.  The page **flips** with a smooth 3D flipping card animation to reveal the back.
        2.  The specific mantra for that Durga begins to chant (audio playback).
    *   **Back of Card Content**:
        *   **Name of the Durga** (in English, Sanskrit, and Malayalam).
        *   **Mantra** in Sanskrit (Devanagari script) and its Malayalam translation.
        *   **Description** of the Durga's significance in Malayalam.
        *   An option to pause/replay the mantra audio.

---

## 5. Development Phases

### Phase 1: Core Foundation & UI Setup
*   Set up Flutter project following the engineering standard guidelines.
*   Define the color palette and typography in `ThemeData`.
*   Establish folder structure (`lib/core`, `lib/features/navadurga`, etc.).

### Phase 2: Carousel & Flipping Card Component
*   Implement `PageView` for swiping between the 9 Durgas.
*   Build the interactive 3D flipping card widget.
*   Implement the custom Pushpanjali (flower offering) animation.

### Phase 3: Content & Audio Integration
*   Prepare the content asset (JSON or local DB) containing names, mantras, and descriptions in Malayalam.
*   Integrate audio playback library (e.g., `audioplayers`) for mantra chants.
*   Add asset files for images and audio files.

### Phase 4: Transitions & Visual Polish
*   Implement the blooming splash screen.
*   Refine micro-animations (page transitions, hover/tap states, custom scroll physics).
*   Optimize audio lifecycle (stop playback when swiping away).

### Phase 5: Verification & Testing
*   Verify UI rendering across different screen aspect ratios.
*   Ensure smooth 60fps animations.
*   Validate all translations and audio/visual matches.

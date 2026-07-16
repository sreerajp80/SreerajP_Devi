# AGENTS.md — SreerajP_Devi

This file gives rules for anyone (including the AI assistant) working on this project.
Read it before making any change. See [docs/architecture.md](../docs/architecture.md) for the full technical design. Refer to the shared guidelines in [docs/GUIDELINES_MANIFEST.md](../docs/GUIDELINES_MANIFEST.md) for the project-wide engineering standards.

---

## 1. What this app is

An **Android app built in Flutter** depicting the **Nine Durgas (Navadurga)**. It features an interactive, highly polished devotional user experience:
- An app icon designed as a **Rakta Kamala (Blood-Red Lotus)**, intended to be placed at the feet of the Devi on the user's home screen wallpaper.
- A **blooming lotus splash transition** on launch with a temple bell / shankha audio chime.
- A page-swiping **Carousel** of the Nine Durgas.
- An interactive **Pushpanjali (floral offering)** gesture where a red lotus is offered at the feet of each Durga.
- A **3D Flipping Card** animation that flips the Durga's portrait on offering/tap to show:
  1. Name of the Durga (English, Sanskrit, Malayalam)
  2. Mantra in Sanskrit (Devanagari) and Malayalam translation
  3. Description of the Durga in Malayalam
- High-quality audio playback of the specific mantra chant for each Durga.

See [docs/SreerajP_Devi_Idea.md](../docs/SreerajP_Devi_Idea.md) for the full product idea.

---

## 2. Tech stack (fixed)

- **Flutter 3.41.9 or higher**
- **Dart 3.11.5 or higher**
- **minSdk 21 (Android 5.0)**; phones and tablets, portrait only (lock orientation for standard experience).
- **Material 3** modern UI with a custom theme.
- **Application ID / Package:** `in.sreerajp.devi`
- **Project Name:** `sreerajp_devi`

---

## 3. Hard rules for this project

These are **must-follow** rules. They override convenience.

1. **Open source only.** Every library used must be **open source**. Commercial or source-available SDKs are **not allowed**, even with a free community license (for example, **Syncfusion is banned**). Check a package's license before adding it.
2. **Offline-first.** The app must work fully offline. All images (Durga portraits), audio files (mantras, bells, chimes), and text contents (Malayalam descriptions, Sanskrit mantras) must be bundled locally inside the asset bundle. No network calls to fetch assets.
3. **Devotional Theme & Color Locking.** The app UI must adhere strictly to the extracted wallpaper color scheme:
   - Primary: `#8B0000` (Rakta Red)
   - Secondary: `#D4AF37` (Swarna Gold)
   - Background: `#FDF6E2` (Warm Ghee/Turmeric White)
   - Accent: `#0F5257` (Mayura Peacock Blue/Green)
4. **Clean Audio Lifecycle.**
   - Playing a mantra audio must automatically stop any other playing audio in the app (e.g. previous mantra, splash chime).
   - Swiping to another page in the carousel must pause or stop the active mantra audio to prevent overlaps.
   - Leaving the app or putting it in the background must stop or pause audio.
5. **Malayalam Text Rendering & Fonts.**
   - The Malayalam font must render correctly with modern/traditional ligatures. Use a verified Google Font (like `Manjari` or `Gayathri`).
   - Text descriptions must be clear and readable, respecting font scaling.
6. **Graceful Asset Loading & Error Handling.**
   - The app must never crash if an audio asset is missing or fails to play. Catch playback errors and degrade gracefully (e.g. show visual text/mantra details without crashing).
   - Provide a safe fallback image or loading placeholder for Durga portraits.
7. **Interactive Flower Offering (Pushpanjali).**
   - The interactive gesture (flower rising from bottom to the feet pedestal of the Durga) must be smooth and lag-free (60fps).
   - The transition between the offering animation, the card flip, and the audio start must be perfectly synchronized.

---

## 4. Security rules

- **Asset Integrity**: Ensure assets are loaded securely and verified.
- **Do not request unnecessary permissions**: The app does not need storage permissions, network permissions, or location permissions. It only needs basic audio playback settings.
- **Read the full security rules** in [docs/security-rules.md](../docs/security-rules.md) before changing security-sensitive code.

---

## 5. Where things live

```
.agents/AGENTS.md       # this file — project rules
docs/                   # product idea and design notes
docs/SreerajP_Devi_Idea.md # full product idea and requirements
docs/GUIDELINES_MANIFEST.md # pointer to shared guidelines
docs/guidelines/        # shared Flutter guidelines submodule
docs/architecture.md    # full technical design
docs/security-rules.md  # full security rules
docs/workflow-rules.md  # full plan/approval/change-log workflow rules
plans/                  # one plan per change
change_log/             # one log per implemented change
assets/                 # app assets (images, audio, config)
lib/                    # app source (to be created)
test/                   # unit and widget tests (to be created)
```

---

## 6. Testing expectations

- **Carousel & Navigation**: Swipe transitions must be testable via widget tests.
- **Card Flip**: The widget must flip successfully on tap or pushpanjali event.
- **Audio service**: Test playing, pausing, and stopping audio playback states.
- **Config Loader**: Test loading and decoding the About config values from `assets/config/app_config.json`.

---

## 7. Workflow rules (mandatory)

Every change must follow the plan-before-changing and log-after-changing process. The full workflow rules live in [docs/workflow-rules.md](../docs/workflow-rules.md).

**Read [docs/workflow-rules.md](../docs/workflow-rules.md) before starting or finishing any change to the project.** In short: write a plan to `plans/` and get explicit approval before editing, then write a change log to `change_log/` after.

Follow the standards and guidelines listed in [docs/GUIDELINES_MANIFEST.md](../docs/GUIDELINES_MANIFEST.md). Specifically, see:
- [Engineering Standard](../docs/guidelines/flutter_project_engineering_standard.md)
- [Architecture Blueprint](../docs/guidelines/architecture.md)

---

## 8. Communication rules

- **Always use simple English.** Write all responses, plans, change logs, and explanations in plain, simple English. Prefer short sentences and common words. Avoid jargon unless it is necessary, and explain it when used.

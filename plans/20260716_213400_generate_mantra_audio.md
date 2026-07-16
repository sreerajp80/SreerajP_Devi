# Generate Real Mantra Audio Files and Chime SFX

**Status:** completed

This plan describes how we will generate real, high-quality audio files for the 9 Navadurga mantras and the SFX chime, replacing the 40-byte placeholder files currently in the workspace.

## Issue

The current mantra audio files (`assets/audio/mantras/*.mp3`) and the temple bell chime (`assets/audio/sfx/chime.mp3`) are 40-byte silent placeholder files. The application needs real audio recordings to provide a devotional experience.

## Plan

1. Install `edge-tts` Python library to generate the 9 mantra audio files using a neural Text-To-Speech engine.
2. Use Microsoft Edge's high-quality female Malayalam neural voice (`ml-IN-SobhanaNeural`) to read the Sanskrit mantras written in Malayalam script (`mantraMalayalam`) at a reduced speed of -20% (`rate="-20%"`) to make the chanting peaceful, rhythmic, and devotional.
3. Download the temple bell chime from Adafruit's official repository for `chime.mp3`.
4. Run the Python script to overwrite the existing placeholder MP3 files.
5. Correct the Malayalam spelling for Chandraghanta (ID 3) in `assets/data/navadurga_data.json` from `ചന്ദ്രഘണ്ഡാ` / `ചന്ദ്രഘണ്ഡേതി` to `ചന്ദ്രഘണ്ടാ` / `ചന്ദ്രഘണ്ടേതി` (fixing `ണ്ഡ` (ṇḍa) to `ണ്ട` (ṇṭa)) to fix the pronunciation and display.
6. Correct `ചണ്ഡകോപാസ്ത്രകൈര്യുതാ` to `ചണ്ഡകോപാസ്ത്രകൈർയുതാ` (using the chilu-r `ർ` + `യു` instead of the complex conjunct `ര്യു`) to ensure `kairyutā` is pronounced correctly instead of being misread as "devika".
7. Modify the python script to only regenerate `3_chandraghanta.mp3` as requested.
8. Verify the files by playing them and testing in the Flutter application.

## Files to change

1. `assets/audio/mantras/1_shailaputri.mp3`
2. `assets/audio/mantras/2_brahmacharini.mp3`
3. `assets/audio/mantras/3_chandraghanta.mp3`
4. `assets/audio/mantras/4_kushmanda.mp3`
5. `assets/audio/mantras/5_skandamata.mp3`
6. `assets/audio/mantras/6_katyayani.mp3`
7. `assets/audio/mantras/7_kalaratri.mp3`
8. `assets/audio/mantras/8_mahagauri.mp3`
9. `assets/audio/mantras/9_siddhidatri.mp3`
10. `assets/audio/sfx/chime.mp3`
11. `bin/generate_mantras.py` [NEW]

## Verification

- Verify that all MP3 files are successfully written and have non-zero sizes.
- Verify audio playability on the system or inside the app.

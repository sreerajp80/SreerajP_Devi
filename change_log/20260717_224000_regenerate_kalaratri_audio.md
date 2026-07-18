# Change Log - Regenerated Kalaratri Mantra Audio and Fix Malayalam Lyrics

Implements the plan in [plans/20260717_223800_regenerate_kalaratri_audio.md](file:///l:/Android/SreerajP_Devi/plans/20260717_223800_regenerate_kalaratri_audio.md).

## What was changed

- Corrected the Malayalam spelling for Goddess Kalaratri (ID 7) in [navadurga_data.json](file:///l:/Android/SreerajP_Devi/assets/data/navadurga_data.json) by changing `ജപാകർണ്ണപൂര` to `ജപാകർണ്ണപൂരാ` and `വർദ്ധനമూర్ദ്ധ്വജാ` to `വർദ്ധനമూర్ദ്ധധ്വജാ`. This fixes the phonetic flow and ensures accurate Sanskrit pronunciation.
- Updated [generate_mantras.py](file:///l:/Android/SreerajP_Devi/bin/generate_mantras.py) to target ID 7 (Kalaratri), set volume to `+100%`, and transcode the output to 160 kbps, 44100 Hz using `imageio-ffmpeg` package.
- Generated and saved the updated, high-quality audio file to [7_kalaratri.mp3](file:///l:/Android/SreerajP_Devi/assets/audio/mantras/7_kalaratri.mp3) (size: 371,505 bytes, 160 kbps, 44100 Hz).
- Cleaned up the temporary virtual environment (`temp_test_env`) and temporary audio files.

## Verification results

- Verified size and audio properties:
  - Format: MPEG 1, Layer III
  - Bitrate: 160 kbps
  - Sample Rate: 44,100 Hz
  - Estimated Duration: 18.58 seconds
- Ran `flutter analyze` and got `No issues found!`.
- Ran `flutter test` and all 17 unit and widget tests passed successfully.

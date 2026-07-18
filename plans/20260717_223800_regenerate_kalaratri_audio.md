# Regenerate Kalaratri Mantra Audio and Fix Malayalam Lyrics

**Status:** completed

This plan describes how we will correct the Malayalam spelling/lyrics for Goddess Kalaratri to make them fluent and phonetically accurate to the Sanskrit original, and regenerate the audio file using `edge-tts` at 160 kbps and 44100 Hz.

## Issue

1. The Malayalam lyrics for Goddess Kalaratri (ID 7) in [navadurga_data.json](file:///l:/Android/SreerajP_Devi/assets/data/navadurga_data.json) contain spelling inaccuracies that affect the flow of the TTS pronunciation:
   - `ജപാകർണ്ണപൂര` (japākarṇapūra) instead of `ജപാകർണ്ണപൂരാ` (japākarṇapūrā) for "जपाकर्णपूра".
   - `വർദ്ധനമൂർദ്ധ്വജാ` (vardhanamūrddhvajā) instead of `വർദ്ധനമൂർദ്ധധ്വജാ` (vardhanamūrdhadhvajā) for "वर्धनमूर्धध्वजा".
2. The current audio file `assets/audio/mantras/7_kalaratri.mp3` in the workspace is very feeble/quiet compared to other mantra audios, and the lyrics are not fluent.
3. The other audio files in the workspace have a bitrate of 160 kbps and a sample rate of 44100 Hz, while the default `edge-tts` output is 48 kbps and 24000 Hz. We need Kalaratri's audio to match this quality and format.

## Proposed Changes

We will modify the Malayalam script details in the JSON file, generate the audio using `edge-tts` with double volume (`volume="+100%"`), and then transcode the file to **160 kbps** and **44100 Hz** using a local `ffmpeg` binary.

### Data Update

#### [MODIFY] [navadurga_data.json](file:///l:/Android/SreerajP_Devi/assets/data/navadurga_data.json)
- Correct the Kalaratri (ID 7) Malayalam mantra text:
  - Update `ജപാകർണ്ണപൂര` to `ജപാകർണ്ണപൂരാ`.
  - Update `വർദ്ധനമൂർദ്ധ്വജാ` to `വർദ്ധനമൂർദ്ധധ്വജാ`.

### Generator Script Update

#### [MODIFY] [generate_mantras.py](file:///l:/Android/SreerajP_Devi/bin/generate_mantras.py)
- Change targeted item ID constraint from `3` (Chandraghanta) to `7` (Kalaratri).
- Pass `volume="+100%"` into the `edge_tts.Communicate` constructor to double the volume.
- Ensure the rate is set to `"-20%"` for a peaceful, slow chant.
- Add code to transcode the generated file using `imageio-ffmpeg` to target 160 kbps (`-b:a 160k`) and 44100 Hz (`-ar 44100`).

### Audio Regeneration Execution
- Run `bin/generate_mantras.py` in a temporary Python virtual environment.
- Install `edge-tts` and `imageio-ffmpeg` in the virtual environment.
- Run the generation and transcoding.
- Delete the temporary virtual environment after completion.

## Verification Plan

### Automated Tests
- Run `flutter analyze` to ensure there are no compilation or static analysis issues.
- Run `flutter test` to verify that all 17 widget and unit tests pass.

### Manual Verification
- Check the generated audio file size (expected to be ~280KB for a 14-second audio at 160 kbps).
- Verify the bitrate (160 kbps) and sample rate (44100 Hz) using Python to ensure it matches the other files.

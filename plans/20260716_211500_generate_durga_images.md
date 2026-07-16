# Plan - Generate Durga Portraits for Navadurga app

**Status:** completed

This plan describes the process to generate the actual portrait images of the Nine Durgas (Navadurga) to replace the 67-byte placeholder image files.

---

## 1. What the issue is

The files `1_shailaputri.png` through `9_siddhidatri.png` under `assets/images/durgas/` are currently 67-byte placeholder files. We need to generate high-quality, authentic traditional Indian paintings representing each Durga form to match the sacred, vintage, and warm devotional theme of the app.

---

## 2. Plan for the fix

1. Define a consistent and highly descriptive prompt template for the image generator tool.
2. The style will match the Bala Tripurasundari wallpaper aesthetic:
   - Primary: `#8B0000` (Rakta Red)
   - Secondary: `#D4AF37` (Swarna Gold)
   - Background: `#FDF6E2` (Warm Ghee/Turmeric White)
   - Accent: `#0F5257` (Mayura Peacock Blue/Green)
   - Style: Classic traditional Indian oil painting style (e.g. vintage calendar art/Raja Ravi Varma style), centered composition, no frames, highly detailed.
3. Generate each of the 9 images using the `generate_image` tool:
   - `1_shailaputri.png`
   - `2_brahmacharini.png`
   - `3_chandraghanta.png`
   - `4_kushmanda.png`
   - `5_skandamata.png`
   - `6_katyayani.png`
   - `7_kalaratri.png`
   - `8_mahagauri.png`
   - `9_siddhidatri.png`
4. Replace the placeholder files with the generated images.
5. Verify the files are correctly overwritten and have substantial sizes.
6. Verify no build or test issues in Flutter.

---

## 3. Files to be changed

### New Files
- None

### Modified Files
- `assets/images/durgas/1_shailaputri.png`
- `assets/images/durgas/2_brahmacharini.png`
- `assets/images/durgas/3_chandraghanta.png`
- `assets/images/durgas/4_kushmanda.png`
- `assets/images/durgas/5_skandamata.png`
- `assets/images/durgas/6_katyayani.png`
- `assets/images/durgas/7_kalaratri.png`
- `assets/images/durgas/8_mahagauri.png`
- `assets/images/durgas/9_siddhidatri.png`

---

## 4. Verification Plan

- Check that each file is overwritten successfully and has non-trivial size (several hundred KBs).
- Run `flutter analyze` to verify the code remains healthy.
- Run `flutter test` to ensure all existing widget/unit tests pass.

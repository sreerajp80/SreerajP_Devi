# Plan - Implement Rakta Kamala App Icon & Assets

**Status:** completed

This plan implements the Rakta Kamala (Blood-Red Lotus) app launcher icon and updates the in-app assets to replace the 1x1 transparent placeholder.

---

## 1. What the issue is

The app launcher icon is currently the default Flutter icon. In addition, the in-app lotus image asset (`assets/images/ui/lotus.png`) is a 1x1 transparent placeholder. We need a high-fidelity stylized Rakta Kamala image asset to be used both for the launcher icon and the in-app flower offering interaction.

---

## 2. Plan for the fix

1. Generate a high-fidelity stylized Rakta Kamala (Blood-Red Lotus) image using the `generate_image` tool.
2. Save it to `assets/images/ui/lotus.png` in the workspace.
3. Configure `flutter_launcher_icons` in `pubspec.yaml` with the path to the newly created asset.
4. Run `flutter pub get` and `flutter pub run flutter_launcher_icons` to generate the platform-specific launcher icons.
5. Run `flutter analyze` and `flutter test` to verify everything is correct.

---

## 3. Files to be changed

### New Files
- None

### Modified Files
- `assets/images/ui/lotus.png` (overwritten)
- `pubspec.yaml`

---

## 4. Verification Plan

- Run `flutter pub run flutter_launcher_icons` and verify it succeeds.
- Check generated Android mipmap files to verify `ic_launcher.png` size has increased and matches the Rakta Kamala image.
- Run `flutter analyze` to ensure no lint warnings/errors.
- Run `flutter test` to ensure all 17 tests pass successfully.

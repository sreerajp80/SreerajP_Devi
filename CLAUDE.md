# SreerajP_Devi - Flutter App

Development and build commands for the Devi app.

## Guidelines
- **Project Rules**: Follow the instructions and rules in [.agents/AGENTS.md](file:///l:/Android/SreerajP_Devi/.agents/AGENTS.md).
- **Workflow & Change Rules**: Follow the planning and logging rules in [docs/workflow-rules.md](file:///l:/Android/SreerajP_Devi/docs/workflow-rules.md).
- **Security Rules**: Follow the security constraints in [docs/security-rules.md](file:///l:/Android/SreerajP_Devi/docs/security-rules.md).
- **Shared Guidelines**: Follow the Flutter guidelines listed in [GUIDELINES_MANIFEST.md](file:///l:/Android/SreerajP_Devi/docs/GUIDELINES_MANIFEST.md).

## Build & Run Commands
- Run Flutter App (dev): `flutter run --flavor dev`
- Run Flutter App (prod): `flutter run --flavor prod`
  - The app defines `dev` and `prod` product flavors, so a bare `flutter run` without
    `--flavor` will fail. Always pass a flavor on Android/iOS.
- Build prod release APK (needs `android/key.properties` + keystore — see
  `android/key.properties.example`):
  `flutter build apk --flavor prod --release --obfuscate --split-debug-info=build/symbols/android-prod-<version>/ --split-per-abi`
- Build prod Play Store bundle:
  `flutter build appbundle --flavor prod --release --obfuscate --split-debug-info=build/symbols/android-prod-<version>/`
- Run Tests: `flutter test`
- Get Dependencies: `flutter pub get`
- Clean Project: `flutter clean`
- Code Analysis: `flutter analyze`

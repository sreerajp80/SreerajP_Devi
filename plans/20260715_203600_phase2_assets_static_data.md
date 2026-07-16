# Plan - Phase 2: Assets & Static Data Integration

**Status:** completed

This plan implements Phase 2 of the Devi (Navadurga) project. It integrates local assets (JSON configuration, static Navadurga Malayalam content, placeholder image, and audio files) and creates the data access layer (models and repositories) in Dart.

---

## 1. What the issue is

To build an offline-first, high-fidelity devotional app, the application metadata and the details of the Nine Durgas (names, Sanskrit mantras, Malayalam translations, and descriptions) must be integrated locally.
We need:
1. JSON data files: `assets/config/app_config.json` and `assets/data/navadurga_data.json`.
2. Model classes: `AppConfig` and `DurgaModel`.
3. Loader services: `ConfigService` and `DurgaRepository`.
4. Mock placeholder assets for Durga portraits (`assets/images/durgas/`), UI icons (`assets/images/ui/`), mantra audio tracks (`assets/audio/mantras/`), and SFX (`assets/audio/sfx/`) to allow the app to compile, load, and run without crashes.
5. Unit tests to verify the config and data loading.

---

## 2. Plan for the fix

### Assets & Data Creation
1. **JSON Configuration**: Create `assets/config/app_config.json` conforming to the about-screen schema from the project guidelines.
2. **Navadurga Data**: Create `assets/data/navadurga_data.json` containing complete Malayalam names, Devanagari and Malayalam script mantras, and Malayalam significance descriptions for all 9 Durgas.
3. **Placeholder Asset Generation**:
   - Write a Dart utility script (`bin/generate_placeholders.dart`) to create valid, minimal files:
     - 1x1 transparent PNG files for all 9 Durga portraits and the lotus UI icon.
     - 100ms silent WAV files (renamed/saved as MP3 or WAV) for mantras and SFX so they load successfully without throw/crash exceptions.
   - Run the script to generate these files inside the assets directory.
   - Ensure these files are ignored in `.gitignore` if needed, or check if they should be committed. (Since they are small placeholder assets, they should be committed so the build works out-of-the-box for any checkouts).

### Models & Repositories
4. **AppConfig Model**: Implement `lib/core/config/app_config.dart` exactly as specified in the guidelines.
5. **ConfigService Loader**: Implement `lib/core/config/config_service.dart` exactly as specified in the guidelines, integrating with `package_info_plus`.
6. **Durga Model**: Implement `lib/models/durga_model.dart` representing a single Durga's static details.
7. **Durga Repository**: Implement `lib/repositories/durga_repository.dart` that loads `navadurga_data.json` and provides the list of 9 Durgas.
8. **Riverpod Providers**: Set up Riverpod providers for `configService` and `durgaRepository` in `lib/core/providers/config_provider.dart` (or similar) to make it easy to inject and mock them in unit/widget tests.

### Verification & Tests
9. **Unit Tests**: Create `test/config_loader_test.dart` and `test/durga_repository_test.dart` to verify successful asset loading and fallback behaviors.

---

## 3. Files to be changed

### New Files
- `assets/config/app_config.json`
- `assets/data/navadurga_data.json`
- `lib/core/config/app_config.dart`
- `lib/core/config/config_service.dart`
- `lib/models/durga_model.dart`
- `lib/repositories/durga_repository.dart`
- `lib/core/providers/providers.dart`
- `bin/generate_placeholders.dart` (temp generator script)
- `test/config_loader_test.dart`
- `test/durga_repository_test.dart`

### Modified Files
- `docs/implementation_progress.md` (to track progress)
- `pubspec.yaml` (ensure assets are configured properly if needed, although they are already registered)

---

## 4. Verification Plan

- Run `dart run bin/generate_placeholders.dart` to create the mock image/audio files.
- Run `flutter test` to execute all unit tests.
- Run `flutter analyze` to ensure clean code analysis.

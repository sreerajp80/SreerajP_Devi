# Change Log - Malayalam Scrollable Detailed Content for Mahagauri Card Back

This change log documents the implementation of scrollable detailed sections in Malayalam on the back side of the Mahagauri card, following the approved plan: [20260718_094711_mahagauri_card_scroll.md](../plans/20260718_094711_mahagauri_card_scroll.md).

---

## 1. Description of Change

Implemented detailed spiritual and chakra sections for Mahagauri in Malayalam:
1. **ആത്മീയ പ്രാധാന്യം** (Spiritual Significance)
2. **ബന്ധപ്പെട്ട ചക്രം** (Associated Chakra)
3. **ആരാധനയുടെ അനുഗ്രഹങ്ങൾ** (Blessings of Worship)
4. **പ്രിയപ്പെട്ട വഴിപാടുകൾ (നൈവേദ്യം)** (Favorite Offerings (Naivedya))
5. **പ്രതീകാത്മക പാഠങ്ങൾ** (Symbolic Lessons)

These are stored in `assets/data/navadurga_data.json` under `additionalSections` for the eighth card (ID 8). They are parsed dynamically and rendered within the scrollable details column.

Additionally, resolved a platform channel deadlock in `test/widget_test.dart` by overriding the loaders to read the real filesystem files using the synchronous Dart `File` API.

## 2. Files Changed

- **[navadurga_data.json](../assets/data/navadurga_data.json)**: Added structured `additionalSections` metadata translated into Malayalam for Mahagauri (ID 8).
- **[widget_test.dart](../test/widget_test.dart)**: Overrode the `durgaRepositoryProvider` and `configServiceProvider` in `ProviderScope` to avoid platform channel reads.

## 3. Verification

### Automated Tests
Ran `flutter test` at the workspace root:
- Result: **All tests passed!**

### Manual Verification
- Visual layout: The card flips correctly, and the content scrolls smoothly with the appropriate custom styling (gold borders, indicators, and text colors).
- The new content matches exactly with the user request and is presented fully in Malayalam.

# Change Log - Malayalam Scrollable Detailed Content for Shailaputri Card Back

This change log documents the implementation of scrollable detailed sections in Malayalam on the back side of the Shailaputri card, following the approved plan: [20260717_230233_shailaputri_card_scroll.md](../plans/20260717_230233_shailaputri_card_scroll.md).

---

## 1. Description of Change

Implemented rich devotional sections for Shailaputri in Malayalam:
1. **ആത്മീയ പ്രാധാന്യം** (Spiritual Significance)
2. **ബന്ധപ്പെട്ട ചക്രം** (Associated Chakra)
3. **ആരാധനയുടെ അനുഗ്രഹങ്ങൾ** (Blessings of Worship)
4. **പ്രിയപ്പെട്ട വഴിപാടുകൾ (നൈവേദ്യം)** (Favorite Offerings (Naivedya))
5. **പ്രതീകാത്മക പാഠങ്ങൾ** (Symbolic Lessons)

The middle body layout of the `_BackCard` widget in `lib/widgets/flipping_card.dart` has been restructured to scroll both the Malayalam description and the new Malayalam sections inside a scrollbar viewport. The names and mantra remain static at the top, and the audio controls remain static at the bottom.

## 2. Files Changed

- **[navadurga_data.json](../assets/data/navadurga_data.json)**: Added structured `additionalSections` metadata translated into Malayalam for Shailaputri (ID 1).
- **[durga_model.dart](../lib/models/durga_model.dart)**: Created the `AdditionalSection` helper model, updated `DurgaModel` properties, factory parser, serialization, equality, and hash code.
- **[flipping_card.dart](../lib/widgets/flipping_card.dart)**: Modified `_BackCard` to render the `additionalSections` dynamically in a scrollable `Column` with custom card containers, gold headers, gold lotus icons (`Icons.spa`), and gold custom bullets (`Icons.fiber_manual_record`).
- **[durga_repository_test.dart](../test/durga_repository_test.dart)**: Updated repository tests to mock and assert parsing of `additionalSections` with Malayalam content.

## 3. Verification

### Automated Tests
Ran `flutter test` at the workspace root:
- Result: **All tests passed!**
- Verified that model parsing handles Malayalam text encoding and nested collections correctly and doesn't fail on null or missing attributes for other forms.

### Manual Verification
- Visual rendering check: The card flips correctly, scrollbar displays when needed, and the static headers/footers are properly locked.
- The new content matches exactly with the user request and is presented fully in Malayalam.

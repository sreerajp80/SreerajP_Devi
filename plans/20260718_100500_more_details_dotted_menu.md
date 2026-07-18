# Show More Details Screen in Dotted Menu

**Status:** completed

## Issue

The user wants to add a "More Details" section to the app, which should be accessible from a dotted menu in the top bar. The current "About" screen should also be moved to this dotted menu. The "More Details" screen must display specific Malayalam content detailing:
1. Why the Navadurgas are worshipped in that order (representing the evolution of consciousness).
2. How the Navadurgas originated (Cosmic origin from Adi Shakti, and Puranic origin based on Goddess Parvati's life stories).

## Files to change / create

1. **[NEW]** `assets/data/more_details.json`
   - Store the translated Malayalam content offline to meet the offline-first requirement.

2. **[NEW]** `lib/models/more_details_model.dart`
   - Data models to deserialize the JSON content safely. Includes a robust static fallback to ensure the app never crashes.

3. **[MODIFY]** `lib/core/providers/providers.dart`
   - Add `moreDetailsProvider` to read and parse the JSON file.

4. **[NEW]** `lib/screens/more_details_screen.dart`
   - Visual screen styled with the warm devotional theme, displaying tabs for "ആരാധനാ ക്രമം" (Order of Worship) and "ഉത്ഭവം" (Origin).

5. **[MODIFY]** `lib/screens/carousel_screen.dart`
   - Replace the AppBar action's info `IconButton` with a styled `PopupMenuButton`.

6. **[NEW]** `test/more_details_screen_test.dart`
   - Widget tests to verify loading and behavior of the new screen.

## Verification

- Run `flutter analyze`
- Run `flutter test test/more_details_screen_test.dart`
- Run all project tests: `flutter test`
- Launch and manually verify the popup menu and the tab content rendering in Malayalam.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sreerajp_devi/core/providers/providers.dart';
import 'package:sreerajp_devi/models/more_details_model.dart';
import 'package:sreerajp_devi/screens/more_details_screen.dart';

void main() {
  testWidgets('MoreDetailsScreen loads and displays tab content correctly', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(412 * 3.0, 892 * 3.0);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    const mockDetails = MoreDetailsModel(
      orderExplanation: OrderExplanationModel(
        title: 'എന്തുകൊണ്ട് ഈ ക്രമത്തിൽ ആരാധിക്കുന്നു?',
        subtitle: 'നവദുർഗ്ഗാ യാത്ര മനുഷ്യബോധത്തിന്റെ ആത്മീയ പരിണാമത്തെ പ്രതിനിധീകരിക്കുന്നു:',
        stages: [
          StageModel(
            name: 'ശൈലപുത്രി (Shailaputri) Test',
            meaning: 'സ്ഥിരതയും അടിസ്ഥാനവും Test',
          ),
          StageModel(
            name: 'ബ്രഹ്മചാരിണി (Brahmacharini) Test',
            meaning: 'ആത്മശിക്ഷണവും ഭക്തിയും Test',
          ),
        ],
        footer: 'ഈ അന്തിമ ഘട്ടം സാധകന്റെ ആത്മീയ യാത്രയുടെ പൂർത്തീകരണത്തെ പ്രതീകപ്പെടുത്തുന്നു.',
      ),
      originExplanation: OriginExplanationModel(
        title: 'നവദുർഗ്ഗമാരുടെ ഉത്ഭവം എങ്ങനെയായിരുന്നു?',
        intro: 'നവദുർഗ്ഗമാർ ഒരേയൊരു പരമ ദിവ്യ മാതാവിന്റെ ഒൻപത് ഭാവങ്ങളാണ്.',
        subIntro: 'അവരുടെ ഉത്ഭവത്തെക്കുറിച്ച് മനസ്സിലാക്കാൻ രണ്ട് വഴികളുണ്ട്.',
        cosmicOrigin: CosmicOriginModel(
          title: '1. പ്രപഞ്ചോത്പത്തി - ആദിശക്തി Test',
          subtitle: 'ശാക്തേയ ഗ്രന്ഥങ്ങൾ പ്രകാരം:',
          description: 'സൃഷ്ടിക്ക് മുൻപ് സനാതനമായ പരമബോധം മാത്രമേ ഉണ്ടായിരുന്നുള്ളൂ.',
        ),
        puranicOrigin: PuranicOriginModel(
          title: '2. പുരാണങ്ങളിലെ ഉത്ഭവം Test',
          subtitle: 'പാർവ്വതി ദേവിയുടെ ജീവിതവുമായി ബന്ധപ്പെട്ടിരിക്കുന്നു.',
          stories: [
            PuranicStoryModel(
              emoji: '🌺',
              id: 1,
              name: 'ശൈലപുത്രി Test',
              text: 'ഹിമവാന്റെ മകളായി പുനർജനിച്ചു.',
            ),
          ],
        ),
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          moreDetailsProvider.overrideWith((ref) => mockDetails),
        ],
        child: const MaterialApp(
          home: MoreDetailsScreen(),
        ),
      ),
    );

    // Verify initial loading state
    await tester.pumpAndSettle();

    // Verify title in AppBar
    expect(find.text('കൂടുതൽ വിവരങ്ങൾ'), findsOneWidget);

    // Verify Tab titles
    expect(find.text('ആരാധനാ ക്രമം'), findsOneWidget);
    expect(find.text('ഉത്ഭവം'), findsOneWidget);

    // Verify Tab 1 (Worship Order) content is visible
    expect(find.text('ശൈലപുത്രി (Shailaputri) Test'), findsOneWidget);
    expect(find.text('സ്ഥിരതയും അടിസ്ഥാനവും Test'), findsOneWidget);
    expect(find.text('ബ്രഹ്മചാരിണി (Brahmacharini) Test'), findsOneWidget);
    expect(
      find.text('ഈ അന്തിമ ഘട്ടം സാധകന്റെ ആത്മീയ യാത്രയുടെ പൂർത്തീകരണത്തെ പ്രതീകപ്പെടുത്തുന്നു.'),
      findsOneWidget,
    );

    // Verify Tab 2 (Origin) content is not yet visible
    expect(find.text('1. പ്രപഞ്ചോത്പത്തി - ആദിശക്തി Test'), findsNothing);

    // Tap on the second tab to switch tabs
    await tester.tap(find.text('ഉത്ഭവം'));
    await tester.pumpAndSettle();

    // Verify Tab 2 content is now visible
    expect(find.text('നവദുർഗ്ഗമാരുടെ ഉത്ഭവം എങ്ങനെയായിരുന്നു?'), findsOneWidget);
    expect(find.text('1. പ്രപഞ്ചോത്പത്തി - ആദിശക്തി Test'), findsOneWidget);

    // Scroll to see the Puranic origin details at the bottom of the list
    final originListFinder = find.byKey(const Key('origin_list'));
    await tester.drag(originListFinder, const Offset(0, -600));
    await tester.pumpAndSettle();

    expect(find.text('2. പുരാണങ്ങളിലെ ഉത്ഭവം Test'), findsOneWidget);
    expect(find.text('ഹിമവാന്റെ മകളായി പുനർജനിച്ചു.'), findsOneWidget);

    // Verify Tab 1 content is no longer visible
    expect(find.text('ശൈലപുത്രി (Shailaputri) Test'), findsNothing);
  });
}

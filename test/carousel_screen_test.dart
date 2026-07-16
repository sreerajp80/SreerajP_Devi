import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sreerajp_devi/core/providers/providers.dart';
import 'package:sreerajp_devi/models/durga_model.dart';
import 'package:sreerajp_devi/repositories/durga_repository.dart';
import 'package:sreerajp_devi/screens/carousel_screen.dart';

// A mock repository containing 2 simple forms of Durga for widget testing
class FakeDurgaRepository implements DurgaRepository {
  @override
  Future<List<DurgaModel>> getDurgas() async {
    return [
      const DurgaModel(
        id: 1,
        nameEnglish: 'Shailaputri',
        nameSanskrit: 'शैलपुत्री',
        nameMalayalam: 'ശൈലപുത്രി',
        mantraSanskrit:
            'वन्दे वाञ्छितलाभाय चन्द्रार्धकृतशेखраम्। वृषारूढाम् शूलधराम् शैलपुत्रीम् यशस्विनीम्॥',
        mantraMalayalam:
            'വന്ദേ വാഞ്ഛിതലാഭായ ചന്ദ്രാർദ്ധകൃതശേഖരാം | വൃഷാരൂഢാം ശൂലധരാം ശൈലപുത്രീം യശസ്വിനീം ||',
        descriptionMalayalam: 'ശൈലപുത്രി വിവരണം...',
        imagePath: 'assets/images/durgas/1_shailaputri.png',
        audioPath: 'assets/audio/mantras/1_shailaputri.mp3',
      ),
      const DurgaModel(
        id: 2,
        nameEnglish: 'Brahmacharini',
        nameSanskrit: 'ब्रह्मचारिणी',
        nameMalayalam: 'ബ്രഹ്മചാരിണി',
        mantraSanskrit:
            'दधाना करपद्мабхйамакшамалакамандалу। деви прасидату маи...',
        mantraMalayalam: 'ദധാനാ കരപദ്മാഭ്യാമക്ഷമാലാകമണ്ഡലൂ...',
        descriptionMalayalam: 'ബ്രഹ്മചാരിണി വിവരണം...',
        imagePath: 'assets/images/durgas/2_brahmacharini.png',
        audioPath: 'assets/audio/mantras/2_brahmacharini.mp3',
      ),
    ];
  }
}

void main() {
  testWidgets('CarouselScreen PageView swiping and active page updates', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(412 * 3.0, 892 * 3.0);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final fakeRepo = FakeDurgaRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [durgaRepositoryProvider.overrideWithValue(fakeRepo)],
        child: const MaterialApp(home: CarouselScreen()),
      ),
    );

    // Initial loading indicator must be present
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();

    // Verify first Durga (Shailaputri) is shown
    expect(find.text('ഭാവം 1 / 2'), findsOneWidget);
    expect(find.text('ശൈലപുത്രി'), findsOneWidget);
    expect(find.text('SHAILAPUTRI'), findsOneWidget);

    // Swipe to the second page (Brahmacharini)
    await tester.drag(find.byType(PageView), const Offset(-400, 0));
    await tester.pumpAndSettle();

    // Active form indicator must update to 2 / 2
    expect(find.text('ഭാവം 2 / 2'), findsOneWidget);
    expect(find.text('ബ്രഹ്മചാരിണി'), findsOneWidget);
    expect(find.text('BRAHMACHARINI'), findsOneWidget);
  });

  testWidgets('FlippingCard 3D Y-rotation and auto-revert flip on swipe', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(412 * 3.0, 892 * 3.0);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final fakeRepo = FakeDurgaRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [durgaRepositoryProvider.overrideWithValue(fakeRepo)],
        child: const MaterialApp(home: CarouselScreen()),
      ),
    );

    await tester.pumpAndSettle();

    // Verify card is on front side (mantra is not visible yet)
    expect(find.text('ശൈലപുത്രി വിവരണം...'), findsNothing);

    // Tap the card to flip it
    await tester.tap(find.byKey(const ValueKey('durga_card_1')));
    await tester.pumpAndSettle();

    // Now back side details should be visible
    expect(find.text('शैलपुत्री'), findsOneWidget);
    expect(find.text('ശൈലപുത്രി വിവരണം...'), findsOneWidget);

    // Swipe to the next page while the card is flipped
    await tester.drag(find.byType(PageView), const Offset(-400, 0));
    await tester.pumpAndSettle();

    // Active page is now 2 / 2
    expect(find.text('ഭാവം 2 / 2'), findsOneWidget);

    // Swipe back to the first page
    await tester.drag(find.byType(PageView), const Offset(400, 0));
    await tester.pumpAndSettle();

    // Verify first card auto-flipped back to the front (details are hidden again)
    expect(find.text('ഭാവം 1 / 2'), findsOneWidget);
    expect(find.text('ശൈലപുത്രി'), findsOneWidget);
    expect(find.text('ശൈലപുത്രി വിവരണം...'), findsNothing);
  });
}

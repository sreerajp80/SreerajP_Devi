import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sreerajp_devi/screens/splash_screen.dart';
import 'package:sreerajp_devi/screens/carousel_screen.dart';
import 'package:sreerajp_devi/core/providers/providers.dart';
import 'package:sreerajp_devi/models/durga_model.dart';
import 'package:sreerajp_devi/repositories/durga_repository.dart';

// Use a fake repository to speed up testing and isolate database loading
class FakeDurgaRepository implements DurgaRepository {
  @override
  Future<List<DurgaModel>> getDurgas() async {
    return [
      const DurgaModel(
        id: 1,
        nameEnglish: 'Shailaputri',
        nameSanskrit: 'शैलपुत्री',
        nameMalayalam: 'ശൈലപുത്രി',
        mantraSanskrit: 'वन्दे...',
        mantraMalayalam: 'വന്ദേ...',
        descriptionMalayalam: 'ശൈലപുത്രി വിവരണം...',
        imagePath: 'assets/images/durgas/1_shailaputri.png',
        audioPath: 'assets/audio/mantras/1_shailaputri.mp3',
      ),
    ];
  }
}

void main() {
  setUp(() {
    PackageInfo.setMockInitialValues(
      appName: 'Devi (Navadurga)',
      packageName: 'in.sreerajp.devi',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: 'mock_signature',
    );
  });

  testWidgets(
    'SplashScreen renders lotus animation and text, then navigates to CarouselScreen',
    (WidgetTester tester) async {
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
          child: const MaterialApp(home: SplashScreen()),
        ),
      );

      // Verify initial state renders title text
      expect(find.text('നവദുർഗ്ഗ'), findsOneWidget);
      expect(find.text('ഓം ദേവ്യൈ നമഃ'), findsOneWidget);

      // Verify CustomPaint with LotusPainter is present
      expect(
        find.byWidgetPredicate(
          (widget) => widget is CustomPaint && widget.painter is LotusPainter,
        ),
        findsOneWidget,
      );

      // Advance time by 2.5 seconds to complete delay and trigger transition
      await tester.pump(const Duration(milliseconds: 2500));
      await tester.pumpAndSettle();

      // Verify transition has completed and landed on CarouselScreen
      expect(find.byType(CarouselScreen), findsOneWidget);
      expect(find.text('ഭാവം 1 / 1'), findsOneWidget);
      expect(find.text('ശൈലപുത്രി'), findsOneWidget);
    },
  );
}

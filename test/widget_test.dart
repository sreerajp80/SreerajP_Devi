import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';
import 'package:sreerajp_devi/app.dart';
import 'package:sreerajp_devi/screens/carousel_screen.dart';
import 'package:sreerajp_devi/repositories/durga_repository.dart';
import 'package:sreerajp_devi/core/config/config_service.dart';
import 'package:sreerajp_devi/core/providers/providers.dart';

void main() {
  testWidgets('App initialization smoke test', (WidgetTester tester) async {
    // Setup mock PackageInfo for testing environment
    PackageInfo.setMockInitialValues(
      appName: 'Devi (Navadurga)',
      packageName: 'in.sreerajp.devi',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: 'mock_signature',
    );

    tester.view.physicalSize = const Size(412 * 3.0, 892 * 3.0);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // Build our app and trigger a frame, overriding loaders to read from filesystem.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          durgaRepositoryProvider.overrideWithValue(
            DurgaRepository(
              loadAsset: (path) async => File(path).readAsStringSync(),
            ),
          ),
          configServiceProvider.overrideWithValue(
            ConfigService(
              loadAsset: (path) async => File(path).readAsStringSync(),
            ),
          ),
        ],
        child: const DeviApp(),
      ),
    );

    // Verify that the splash screen text/widgets are visible initially
    expect(find.text('നവദുർഗ്ഗ'), findsOneWidget);
    expect(find.text('ഓം ദേവ്യൈ നമഃ'), findsOneWidget);

    // Yield to the real event loop to allow real filesystem asset reads to complete
    await tester.idle();

    // Settle the splash animation and transition to CarouselScreen by pumping in small steps
    for (int i = 0; i < 30; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    
    // Wait for transition to complete, pumping frames as needed
    int retries = 0;
    while (find.text('ശൈലപുത്രി').evaluate().isEmpty && retries < 20) {
      await tester.pump(const Duration(milliseconds: 100));
      retries++;
    }
    await tester.pumpAndSettle();

    // Verify transition has completed and landed on CarouselScreen
    expect(find.byType(CarouselScreen), findsOneWidget);

    // Verify that the first Durga form (Shailaputri) is now loaded on the CarouselScreen
    expect(find.text('ശൈലപുത്രി'), findsOneWidget);
  });
}

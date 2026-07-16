import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sreerajp_devi/app.dart';

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

    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: DeviApp()));

    // Verify that the splash screen text/widgets are visible initially
    expect(find.text('നവദുർഗ്ഗ'), findsOneWidget);
    expect(find.text('ഓം ദേവ്യൈ നമഃ'), findsOneWidget);

    // Settle the splash animation and transition to CarouselScreen
    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pumpAndSettle();

    // Verify that the first Durga form (Shailaputri) is now loaded on the CarouselScreen
    expect(find.text('ശൈലപുത്രി'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sreerajp_devi/screens/about_screen.dart';
import 'package:sreerajp_devi/core/providers/providers.dart';
import 'package:sreerajp_devi/core/config/app_config.dart';

void main() {
  testWidgets('AboutScreen displays config metadata and version', (
    WidgetTester tester,
  ) async {
    final mockConfig = AppConfig(
      appName: 'Devi (Navadurga) Test',
      description: 'Test description of the app.',
      version: '1.2.3',
      build: '4',
      details: const {'Author': 'Sreeraj P Test', 'License': 'Open Source'},
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appConfigProvider.overrideWith((ref) => mockConfig)],
        child: const MaterialApp(home: AboutScreen()),
      ),
    );

    // Initial loading state
    await tester.pumpAndSettle();

    // Verify screen title in Malayalam
    expect(find.text('വിവരങ്ങൾ'), findsOneWidget);

    // Verify app name
    expect(find.text('Devi (Navadurga) Test'), findsOneWidget);

    // Verify description
    expect(find.text('Test description of the app.'), findsOneWidget);

    // Verify version and build (loaded from app_config.json)
    expect(find.text('1.2.3 (Build 4)'), findsOneWidget);

    // Verify author detail
    expect(find.text('Sreeraj P Test'), findsOneWidget);

    // Verify license detail
    expect(find.text('Open Source'), findsOneWidget);

    // Verify license label in Malayalam
    expect(find.text('അനുമതിപത്രം (License)'), findsOneWidget);
    expect(find.text('രചയിതാവ് (Author)'), findsOneWidget);

    // Verify verified badge is visible since versions match
    expect(find.text('Verified'), findsOneWidget);
  });

  testWidgets('AboutScreen pops on back button press', (
    WidgetTester tester,
  ) async {
    final mockConfig = AppConfig(
      appName: 'Devi (Navadurga) Test',
      description: 'Test description.',
      version: '1.2.3',
      build: '4',
      details: const {},
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appConfigProvider.overrideWith((ref) => mockConfig)],
        child: MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AboutScreen(),
                    ),
                  );
                },
                child: const Text('Go'),
              ),
            ),
          ),
        ),
      ),
    );

    // Push the AboutScreen
    await tester.tap(find.text('Go'));
    await tester.pumpAndSettle();

    // Verify we are on the AboutScreen
    expect(find.byType(AboutScreen), findsOneWidget);

    // Tap back button
    final backButton = find.byType(IconButton).first;
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    // Verify AboutScreen is popped and no longer visible
    expect(find.byType(AboutScreen), findsNothing);
  });
}

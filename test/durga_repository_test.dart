import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_devi/repositories/durga_repository.dart';

void main() {
  group('DurgaRepository Tests', () {
    test('loads and parses valid Navadurga JSON', () async {
      final repository = DurgaRepository(
        loadAsset: (path) async {
          return '''
          [
            {
              "id": 1,
              "nameEnglish": "Shailaputri",
              "nameSanskrit": "शैलपुत्री",
              "nameMalayalam": "ശൈലപുത്രി",
              "mantraSanskrit": "वन्दे वाञ्छितलाभाय...",
              "mantraMalayalam": "വന്ദേ വാഞ്ഛിതലാഭായ...",
              "descriptionMalayalam": "പർവ്വതരാജനായ...",
              "imagePath": "assets/images/durgas/1_shailaputri.png",
              "audioPath": "assets/audio/mantras/1_shailaputri.mp3",
              "additionalSections": [
                {
                  "title": "ആത്മീയ പ്രാധാന്യം",
                  "subtitle": "ശൈലപുത്രി പ്രതിനിധീകരിക്കുന്നു:",
                  "bullets": [
                    "പർവ്വതത്തെപ്പോലെയുള്ള ദൃഢതയും സ്ഥിരതയും",
                    "ഉദ്ദേശശുദ്ധി"
                  ],
                  "footer": "യഥാർത്ഥ ആത്മീയ വളർച്ച സുസ്ഥിരവും..."
                }
              ]
            }
          ]
          ''';
        },
      );

      final durgas = await repository.getDurgas();
      expect(durgas.length, equals(1));
      expect(durgas.first.id, equals(1));
      expect(durgas.first.nameEnglish, equals('Shailaputri'));
      expect(durgas.first.nameMalayalam, equals('ശൈലപുത്രി'));
      expect(durgas.first.nameSanskrit, equals('शैलपुत्री'));
      expect(durgas.first.additionalSections.length, equals(1));
      expect(durgas.first.additionalSections.first.title, equals('ആത്മീയ പ്രാധാന്യം'));
      expect(durgas.first.additionalSections.first.subtitle, equals('ശൈലപുത്രി പ്രതിനിധീകരിക്കുന്നു:'));
      expect(durgas.first.additionalSections.first.bullets, equals(['പർവ്വതത്തെപ്പോലെയുള്ള ദൃഢതയും സ്ഥിരതയും', 'ഉദ്ദേശശുദ്ധി']));
      expect(durgas.first.additionalSections.first.footer, equals('യഥാർത്ഥ ആത്മീയ വളർച്ച സുസ്ഥിരവും...'));
    });

    test('returns empty list on malformed JSON', () async {
      final repository = DurgaRepository(
        loadAsset: (path) async => '{invalid json list}',
      );

      final durgas = await repository.getDurgas();
      expect(durgas, isEmpty);
    });

    test('returns empty list on exception', () async {
      final repository = DurgaRepository(
        loadAsset: (path) async => throw Exception('File not found'),
      );

      final durgas = await repository.getDurgas();
      expect(durgas, isEmpty);
    });
  });
}

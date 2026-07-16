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
              "audioPath": "assets/audio/mantras/1_shailaputri.mp3"
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

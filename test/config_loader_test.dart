import 'package:flutter_test/flutter_test.dart';
import 'package:sreerajp_devi/core/config/app_config.dart';
import 'package:sreerajp_devi/core/config/config_service.dart';

void main() {
  group('ConfigService Tests', () {
    test('loads valid JSON and returns AppConfig model', () async {
      final service = ConfigService(
        loadAsset: (path) async {
          return '''
          {
            "appName": "Test Devi App",
            "description": "A test app.",
            "version": "2.0.0",
            "build": "42",
            "details": {
              "Author": "Test Author",
              "AI used": "Test AI"
            }
          }
          ''';
        },
      );

      final config = await service.load();
      expect(config.appName, equals('Test Devi App'));
      expect(config.description, equals('A test app.'));
      expect(config.version, equals('2.0.0'));
      expect(config.build, equals('42'));
      expect(config.details['Author'], equals('Test Author'));
      expect(config.details['AI used'], equals('Test AI'));
    });

    test('falls back to default config on malformed JSON', () async {
      final service = ConfigService(
        loadAsset: (path) async => '{invalid json}',
      );

      final config = await service.load();
      expect(config.appName, equals(AppConfig.fallback.appName));
      expect(config.version, equals(AppConfig.fallback.version));
    });

    test('falls back to default config on asset loading exception', () async {
      final service = ConfigService(
        loadAsset: (path) async => throw Exception('Asset missing'),
      );

      final config = await service.load();
      expect(config.appName, equals(AppConfig.fallback.appName));
      expect(config.version, equals(AppConfig.fallback.version));
    });
  });
}

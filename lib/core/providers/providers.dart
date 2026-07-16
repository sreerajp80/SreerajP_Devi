import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_config.dart';
import '../config/config_service.dart';
import '../../models/durga_model.dart';
import '../../repositories/durga_repository.dart';
import '../audio/audio_service.dart';

/// Provider for [AudioService] instance.
final audioServiceProvider = Provider<AudioService>((ref) {
  final service = AudioService();
  ref.onDispose(() {
    service.dispose();
  });
  return service;
});

/// Provider for [ConfigService] instance.
final configServiceProvider = Provider<ConfigService>((ref) {
  return ConfigService();
});

/// Provider for [DurgaRepository] instance.
final durgaRepositoryProvider = Provider<DurgaRepository>((ref) {
  return DurgaRepository();
});

/// Async notifier/future provider that loads and caches the [AppConfig].
final appConfigProvider = FutureProvider<AppConfig>((ref) async {
  final service = ref.watch(configServiceProvider);
  return service.loadAndVerify();
});

/// Async notifier/future provider that loads and caches the Navadurga list.
final durgasProvider = FutureProvider<List<DurgaModel>>((ref) async {
  final repository = ref.watch(durgaRepositoryProvider);
  return repository.getDurgas();
});

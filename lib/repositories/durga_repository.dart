import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/durga_model.dart';

/// Repository responsible for loading and parsing the static Malayalam/Sanskrit
/// Navadurga details from `assets/data/navadurga_data.json`.
class DurgaRepository {
  static const String assetPath = 'assets/data/navadurga_data.json';

  final Future<String> Function(String path) _loadAsset;

  DurgaRepository({Future<String> Function(String path)? loadAsset})
    : _loadAsset = loadAsset ?? rootBundle.loadString;

  /// Loads, parses, and returns the list of 9 Navadurga forms.
  /// Returns an empty list in case of errors (missing assets, malformed JSON).
  Future<List<DurgaModel>> getDurgas() async {
    try {
      final text = await _loadAsset(assetPath);
      final decoded = jsonDecode(text);
      if (decoded is! List) return const [];

      return decoded
          .map((item) => DurgaModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return const [];
    }
  }
}

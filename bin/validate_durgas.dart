import 'dart:convert';
import 'dart:io';
import 'package:sreerajp_devi/models/durga_model.dart';

void main() {
  try {
    final file = File('assets/data/navadurga_data.json');
    final text = file.readAsStringSync();
    final decoded = jsonDecode(text) as List<dynamic>;
    final durgas = decoded.map((item) => DurgaModel.fromJson(item as Map<String, dynamic>)).toList();
    stdout.writeln('Parsed ${durgas.length} Durgas successfully!');
  } catch (e, stack) {
    stderr.writeln('Parsing Error: $e');
    stderr.writeln(stack);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() async {
  // Ensure Flutter bindings are initialized before accessing platform features
  WidgetsFlutterBinding.ensureInitialized();

  // Lock the orientation to portrait-only, as per the design guidelines
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    // Wrap the app in ProviderScope to enable Riverpod state management
    const ProviderScope(child: DeviApp()),
  );
}

import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/splash_screen.dart';

/// The root widget of the Devi (Navadurga) application.
/// Configures MaterialApp with the custom devotional theme.
class DeviApp extends StatelessWidget {
  const DeviApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devi (Navadurga)',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// AppTheme configuration for Devi (Navadurga) App.
/// Provides a Material 3 theme incorporating the locked devotional color scheme
/// and verified typography for English and Malayalam text.
class AppTheme {
  AppTheme._();

  /// Returns the customized [ThemeData] for a warm, devotional visual style.
  static ThemeData get lightTheme {
    final baseColorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.raktaRed,
      primary: AppColors.raktaRed,
      secondary: AppColors.swarnaGold,
      surface: AppColors.haridraBackground,
      onPrimary: Colors.white,
      onSecondary: AppColors.textDark,
      onSurface: AppColors.textDark,
      error: AppColors.raktaRed,
      outline: AppColors.swarnaGold.withValues(alpha: 0.5),
    );

    // Use traditional Cinzel font for display/titles, and Manjari for body text.
    // Manjari works beautifully for both English and Malayalam.
    final baseTextTheme = GoogleFonts.manjariTextTheme();
    final titleFont = GoogleFonts.cinzel();

    final customTextTheme = baseTextTheme.copyWith(
      displayLarge: titleFont.copyWith(
        color: AppColors.raktaRed,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: titleFont.copyWith(
        color: AppColors.raktaRed,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: titleFont.copyWith(
        color: AppColors.raktaRed,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: titleFont.copyWith(
        color: AppColors.raktaRed,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: titleFont.copyWith(
        color: AppColors.raktaRed,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: titleFont.copyWith(
        color: AppColors.raktaRed,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: titleFont.copyWith(
        color: AppColors.raktaRed,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        color: AppColors.textDark,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: baseTextTheme.titleSmall?.copyWith(
        color: AppColors.textDark,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        color: AppColors.textDark,
        height: 1.4,
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        color: AppColors.textDark,
        height: 1.4,
      ),
      bodySmall: baseTextTheme.bodySmall?.copyWith(
        color: AppColors.textDark.withValues(alpha: 0.7),
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: baseColorScheme,
      scaffoldBackgroundColor: AppColors.haridraBackground,
      textTheme: customTextTheme,

      // Customize App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: titleFont.copyWith(
          color: AppColors.raktaRed,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: AppColors.raktaRed),
      ),

      // Customize Card Theme for 3D Flipping Card
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: 6,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.swarnaGold, width: 1.5),
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // Customize ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.raktaRed,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: titleFont.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),

      // Customize Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.swarnaGold,
        thickness: 1.0,
        space: 24,
      ),
    );
  }
}

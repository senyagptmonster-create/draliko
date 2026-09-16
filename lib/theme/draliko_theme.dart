import 'package:flutter/material.dart';

class DralikoTheme {
  static const bg = Color(0xFFFFFBEB);
  static const surface = Color(0xFFFFFFFF);
  static const edge = Color(0xFFFDE68A);
  static const accent = Color(0xFFEA580C);
  static const accentLight = Color(0xFFFB923C);
  static const ink = Color(0xFF431407);
  static const muted = Color(0xFF9A3412);

  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: bg,
      fontFamily: 'AppFont',
      primaryColor: accent,
      colorScheme: const ColorScheme.light(
        primary: accent,
        surface: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        foregroundColor: ink,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: edge, width: 1.5),
        ),
      ),
    );
  }
}

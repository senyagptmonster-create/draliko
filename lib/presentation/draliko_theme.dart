import 'package:flutter/material.dart';

class DralikoTheme {
  static const Color warmCrust = Color(0xFF8D5B2A);
  static const Color goldenWheat = Color(0xFFD4A359);
  static const Color flourBeige = Color(0xFFFAF7F2);
  static const Color darkCharcoal = Color(0xFF2B2825);
  static const Color borderCard = Color(0xFFE5DDD0);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'AppFont',
      scaffoldBackgroundColor: flourBeige,
      colorScheme: const ColorScheme.light(
        primary: warmCrust,
        secondary: goldenWheat,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSurface: darkCharcoal,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: warmCrust,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}

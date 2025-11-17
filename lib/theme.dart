import 'package:flutter/material.dart';

class AppTheme {
  static const Color pastelPink = Color(0xFFFDE2E4);
  static const Color pastelPinkDark = Color(0xFFFAD4D8);
  static const Color accentPink = Color(0xFFE5989B);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: pastelPink,
    primaryColor: accentPink,
    appBarTheme: const AppBarTheme(
      backgroundColor: accentPink,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentPink,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: pastelPinkDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

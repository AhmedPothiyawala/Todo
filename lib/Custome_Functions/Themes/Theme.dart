import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white, // Light theme background
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black), // Light theme text
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: Colors.black26, // Dark theme background
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white), // Dark theme text
    ),
  );

  static Future<ThemeData> getThemeFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('darkMode') ?? false;
    return isDarkMode ? darkTheme : lightTheme;
  }
}

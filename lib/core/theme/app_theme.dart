import 'package:flutter/material.dart';
import 'package:myapp/core/theme/colors.dart';

class AppTheme {
  static ThemeData appThemeLight = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: Colors.red,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      // surfaceVariant: Colors.transparent,
      onSurface: Colors.black,
    ),
    fontFamily: 'MTLmr3m',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 18, fontStyle: FontStyle.normal),
      bodyMedium: TextStyle(fontSize: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}

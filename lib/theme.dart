import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFCAF2C2);
  static const Color secondaryColor = Color(0xFFFFE7D1);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFE0FFCC);
  static const Color textColor = Color(0xFF000000);
  static const Color buttonColor = Color(0xFF228B22);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'DmSans', 
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: textColor, // Apply text color
      ), 
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: textColor,
      ), 
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: textColor,
      ), 
      labelSmall: TextStyle(
        fontSize: 14,
        fontStyle: FontStyle.italic,
        color: textColor,
      ),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor, // Button color
        foregroundColor: Colors.white, // Text color on button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}

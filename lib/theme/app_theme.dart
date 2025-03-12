import 'package:flutter/material.dart';

ThemeData getLightTheme(Color accentColor) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: accentColor,
      secondary: accentColor,
      surface: _getLightBackgroundColor(accentColor),
    ),
    scaffoldBackgroundColor: _getLightBackgroundColor(accentColor),
    appBarTheme: AppBarTheme(
      backgroundColor: _getLightBackgroundColor(accentColor),
      elevation: 0,
      iconTheme: IconThemeData(color: accentColor),
      titleTextStyle: TextStyle(
        color: accentColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return accentColor;
        }
        return Colors.grey;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return accentColor.withOpacity(0.5);
        }
        return Colors.grey.withOpacity(0.5);
      }),
    ),
  );
}

ThemeData getDarkTheme(Color accentColor) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: accentColor,
      secondary: accentColor,
      surface: _getDarkBackgroundColor(accentColor),
    ),
    scaffoldBackgroundColor: _getDarkBackgroundColor(accentColor),
    appBarTheme: AppBarTheme(
      backgroundColor: _getDarkBackgroundColor(accentColor),
      elevation: 0,
      iconTheme: IconThemeData(color: accentColor),
      titleTextStyle: TextStyle(
        color: accentColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return accentColor;
        }
        return Colors.grey;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return accentColor.withOpacity(0.5);
        }
        return Colors.grey.withOpacity(0.3);
      }),
    ),
  );
}

Color _getLightBackgroundColor(Color accentColor) {
  if (accentColor == Colors.red) {
    return const Color(0xFFFFF2F2); // Light red background
  } else if (accentColor == Colors.green) {
    return const Color(0xFFF2FFF5); // Light green background
  } else if (accentColor == Colors.blue) {
    return const Color(0xFFF2F9FF); // Light blue background
  }
  return Colors.white;
}

Color _getDarkBackgroundColor(Color accentColor) {
  if (accentColor == Colors.red) {
    return const Color(0xFF471515); // Dark red background
  } else if (accentColor == Colors.green) {
    return const Color(0xFF14401D); // Dark green background
  } else if (accentColor == Colors.blue) {
    return const Color(0xFF153047); // Dark blue background
  }
  return const Color(0xFF1A1A1A); // Default dark background
}
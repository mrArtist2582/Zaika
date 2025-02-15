import 'package:flutter/material.dart';

final ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: Color(0xFF181818), // Dark background
    primary: Color(0xFFFFA825), // Swiggy’s signature orange
    secondary: Color(0xFF222222), // Dark grey for subtle contrast
    tertiary: Color(0xFF303030), // Medium grey for cards, containers
    inversePrimary: Colors.grey.shade300, // Light text/icons for contrast
  ),
);

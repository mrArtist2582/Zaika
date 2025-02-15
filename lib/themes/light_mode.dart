import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.white, // Clean, bright background
    primary: Color(0xFFFFA825), // Swiggy’s signature orange
    secondary: Colors.grey.shade200, // Light grey for subtle contrast
    tertiary: Colors.grey.shade50, // Almost white for cards, containers
    inversePrimary: Colors.grey.shade800, // Dark text/icons for contrast
  ),
);
import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors based on the provided orange
  static const Color primary = Color.fromARGB(255, 239, 110, 59); // Main primary color
  static const Color primaryVariant = Color(0xFFE06A3F); // A darker shade of primary for variation
  static const Color secondary = Color(0xFFFFC107); // Warm yellow for contrast
  static const Color secondaryVariant = Color(0xFFFFA000); // Darker yellow for deeper accent

  // Background and Surface
  static const Color background = Color(0xFFF2F2F2); // Light background for readability
  static const Color surface = Color(0xFFFFFFFF); // Standard white surface for cards and containers

  // Text Colors
  static const Color textPrimary = Color(0xFF333333); // Darker text for high contrast
  static const Color textSecondary = Color(0xFF666666); // Subtle text color for secondary elements

  // Error Colors
  static const Color error = Color(0xFFD32F2F); // Slightly muted red for errors
  
  // Light Theme Colors
  static const Color lightPrimary = primary;
  static const Color lightBackground = background;
  static const Color lightSurface = surface;
  static const Color lightOnPrimary = Color(0xFFFFFFFF); // White text on primary color for readability
  
  // Dark Theme Colors
  static const Color darkPrimary = primary;
  static const Color darkBackground = Color(0xFF212121); // Dark gray for background in dark mode
  static const Color darkSurface = Color(0xFF333333); // Slightly lighter gray for surfaces in dark mode
  static const Color darkOnPrimary = Color(0xFFFFFFFF); // White text on primary color in dark mode

  // Accent Colors
  static const Color accentBlue = Color(0xFF0D47A1); // Deep blue as an accent
  static const Color accentGreen = Color(0xFF388E3C); // Green for positive indicators
  static const Color accentRed = Color(0xFFC62828); // Red for alerts and highlights

  // Additional Colors
  static const Color shadow = Color(0x29000000); // Lighter shadow for subtle depth
  static const Color divider = Color(0xFFBDBDBD); // Standard divider color
}

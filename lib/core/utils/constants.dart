import 'package:flutter/material.dart';

abstract class AppConstants {
  // ============== Border Radius ==============
  static const double radiusCard = 16.0; // Cards
  static const double radiusButton = 8.0; // Buttons
  static const double radiusChip = 12.0; // Badges/Chips
  static const double radiusCircle = 999.0; // Circular elements

  // ============== Spacing ==============
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;

  // ============== Touch Targets ==============
  static const double minTouchTarget = 48.0; // Minimum tap area
  static const double buttonHeight = 48.0; // Default button height
  static const double iconButtonSize = 40.0; // Icon buttons

  // ============== Shadows ==============
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: const Color(0x14000000), // rgba(0,0,0,0.08)
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get buttonShadow => [
    BoxShadow(
      color: const Color(0x4D2563EB), // rgba(37,99,235,0.3)
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: const Color(0x1A000000), // rgba(0,0,0,0.1)
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  // ============== Animations ==============
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Curve animationCurve = Curves.easeInOut;

  // ============== Content Padding (to avoid header overlap) ==============
  static const double contentPaddingTop = 175.0;
  static const double contentPaddingTopLarge = 195.0;

  // ============== Icons (Emoji sizes) ==============
  static const double emojiSmall = 24.0;
  static const double emojiMedium = 48.0;
  static const double emojiLarge = 80.0;
  static const double emojiXLarge = 140.0;
}

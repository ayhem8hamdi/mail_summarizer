import 'package:flutter/material.dart';

abstract class AppColors {
  // ============== Primary Colors ==============
  static const Color kPrimaryBlue = Color(0xFF2563EB); // Main brand color
  static const Color kSecondaryBlue = Color(
    0xFF3B82F6,
  ); // Gradients, hover states
  static const Color kLightBlue = Color(0xFFEFF6FF); // Background highlights
  static const Color kExtraLightBlue = Color(0xFFDBEAFE); // Hover states

  // ============== Background Colors ==============
  static const Color kBackgroundColor = Color(0xFFF8FAFC); // App background
  static const Color kSurfaceColor = Color(0xFFFFFFFF); // Cards, modals

  // ============== Text Colors ==============
  static const Color kTextPrimary = Color(0xFF1E293B); // Headings
  static const Color kTextSecondary = Color(0xFF64748B); // Body text

  // ============== Semantic Colors ==============
  static const Color kPositiveGreen = Color(0xFF10B981); // Positive sentiment
  static const Color kNeutralYellow = Color(0xFFF59E0B); // Neutral/warning
  static const Color kUrgentRed = Color(0xFFEF4444); // Urgent/error

  // ============== UI Element Colors ==============
  static const Color kBorderColor = Color(0xFFE2E8F0); // Borders, dividers
  static const Color kUnreadIndicator = Color(0xFF2563EB); // Unread dot

  // ============== Gradients ==============
  static const LinearGradient kPrimaryGradient = LinearGradient(
    colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient kHeroGradient = LinearGradient(
    colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient kBackgroundGradient = LinearGradient(
    colors: [Color(0xFFF8FAFC), Color(0xFFEFF6FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient kPositiveGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient kNeutralGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient kUrgentGradient = LinearGradient(
    colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ============== Shadow Colors ==============
  static const Color kShadowLight = Color(0x14000000); // rgba(0,0,0,0.08)
  static const Color kShadowPrimary = Color(0x4D2563EB); // rgba(37,99,235,0.3)

  // ============== Glassmorphism Colors ==============
  static final Color kGlassLight = Colors.white.withOpacity(0.2);
  static final Color kGlassHeavy = Colors.white.withOpacity(0.8);
}

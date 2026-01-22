import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/core/utils/responsive_font_size.dart';

abstract class AppStyles {
  // Using Inter font (as specified in design)
  static TextStyle _baseInter(BuildContext context) => GoogleFonts.inter();

  // ============== FontSize 8px (Small notification counts) ==============
  static TextStyle regular8(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 8),
        fontWeight: FontWeight.w400,
        color: AppColors.kTextSecondary,
      );

  // ============== FontSize 10px (Notification badges: URGENT, Action, FYI) ==============
  static TextStyle semiBold10(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 10),
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.5,
      );

  // ============== FontSize 12px (Timestamps, badges, nav labels) ==============
  static TextStyle regular12(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 12),
        fontWeight: FontWeight.w400,
        color: AppColors.kTextSecondary,
      );

  static TextStyle medium12(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 12),
        fontWeight: FontWeight.w500,
        color: AppColors.kTextSecondary,
      );

  static TextStyle semiBold12(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 12),
        fontWeight: FontWeight.w600,
        color: AppColors.kTextPrimary,
      );

  // ============== FontSize 13px (Email previews, security text, sentiment breakdown) ==============
  static TextStyle regular13(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 13),
        fontWeight: FontWeight.w400,
        color: AppColors.kTextSecondary,
      );

  static TextStyle medium13(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 13),
        fontWeight: FontWeight.w500,
        color: AppColors.kTextSecondary,
      );

  // ============== FontSize 14px (Action items, descriptions, buttons, chips) ==============
  static TextStyle regular14(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 14),
        fontWeight: FontWeight.w400,
        color: AppColors.kTextPrimary,
      );

  static TextStyle medium14(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 14),
        fontWeight: FontWeight.w500,
        color: AppColors.kTextPrimary,
      );

  static TextStyle semiBold14(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 14),
        fontWeight: FontWeight.w600,
        color: AppColors.kTextPrimary,
      );

  // ============== FontSize 15px (Email sender names, email body, task text) ==============
  static TextStyle regular15(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 15),
        fontWeight: FontWeight.w400,
        color: AppColors.kTextPrimary,
        height: 1.8, // For email body readability
      );

  static TextStyle semiBold15(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 15),
        fontWeight: FontWeight.w600,
        color: AppColors.kTextPrimary,
      );

  // ============== FontSize 16px (Section headings, modal titles, sender names, descriptions) ==============
  static TextStyle regular16(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 16),
        fontWeight: FontWeight.w400,
        color: AppColors.kTextPrimary,
      );

  static TextStyle medium16(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 16),
        fontWeight: FontWeight.w500,
        color: AppColors.kTextPrimary,
      );

  static TextStyle semiBold16(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 16),
        fontWeight: FontWeight.w600,
        color: AppColors.kTextPrimary,
      );

  // ============== FontSize 18px (Card headings, empty state titles, sentiment labels) ==============
  static TextStyle semiBold18(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 18),
        fontWeight: FontWeight.w600,
        color: AppColors.kTextPrimary,
      );

  static TextStyle bold18(BuildContext context) => _baseInter(context).copyWith(
    fontSize: responsiveFontSize(context, fontSize: 18),
    fontWeight: FontWeight.w700,
    color: AppColors.kTextPrimary,
  );

  // ============== FontSize 20px (Page titles, Priority Inbox, Email detail, Smart Reply) ==============
  static TextStyle semiBold20(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 20),
        fontWeight: FontWeight.w600,
        color: AppColors.kTextPrimary,
      );

  static TextStyle bold20(BuildContext context) => _baseInter(context).copyWith(
    fontSize: responsiveFontSize(context, fontSize: 20),
    fontWeight: FontWeight.w700,
    color: AppColors.kTextPrimary,
  );

  // ============== FontSize 24px (Tasks screen header) ==============
  static TextStyle bold24(BuildContext context) => _baseInter(context).copyWith(
    fontSize: responsiveFontSize(context, fontSize: 24),
    fontWeight: FontWeight.w700,
    color: AppColors.kTextPrimary,
  );

  // ============== FontSize 28px (Onboarding titles) ==============
  static TextStyle bold28(BuildContext context) => _baseInter(context).copyWith(
    fontSize: responsiveFontSize(context, fontSize: 28),
    fontWeight: FontWeight.w700,
    color: AppColors.kTextPrimary,
  );

  // ============== FontSize 32px (Splash screen app name, EmailConnect heading) ==============
  static TextStyle bold32(BuildContext context) => _baseInter(context).copyWith(
    fontSize: responsiveFontSize(context, fontSize: 32),
    fontWeight: FontWeight.w700,
    color: AppColors.kTextPrimary,
  );

  // ============== FontSize 48px (Large numbers - email count on hero card) ==============
  static TextStyle bold48(BuildContext context) => _baseInter(context).copyWith(
    fontSize: responsiveFontSize(context, fontSize: 48),
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  // ============== FontSize 52px (Logo text "IQ" on splash screen) ==============
  static TextStyle bold52(BuildContext context) => _baseInter(context).copyWith(
    fontSize: responsiveFontSize(context, fontSize: 52),
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  // ============== FontSize 80px (Large emoji illustrations) ==============
  // Note: For emojis, use Text widget with fontSize directly, not this style

  // ============== Special Styles ==============

  // Button text (14px semibold)
  static TextStyle buttonText(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 14),
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  // Chip/Badge text (10px semibold)
  static TextStyle chipText(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 10),
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.5,
      );

  // Email body style (15px regular with 1.8 line height)
  static TextStyle emailBody(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 15),
        fontWeight: FontWeight.w400,
        color: AppColors.kTextPrimary,
        height: 1.8,
      );

  // Navigation label (12px regular)
  static TextStyle navLabel(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 12),
        fontWeight: FontWeight.w400,
        color: AppColors.kTextSecondary,
      );

  // Navigation label active (12px semibold)
  static TextStyle navLabelActive(BuildContext context) =>
      _baseInter(context).copyWith(
        fontSize: responsiveFontSize(context, fontSize: 12),
        fontWeight: FontWeight.w600,
        color: AppColors.kPrimaryBlue,
      );
}

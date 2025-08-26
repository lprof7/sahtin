import 'package:flutter/material.dart';

/// نظام الألوان للتطبيق - Sahtin Color Palette
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFFFF7043); // برتقالي دافئ
  static const Color secondary = Color(0xFF6D4C41); // بني متوسط
  static const Color accent = Color(0xFFFFA726); // برتقالي فاتح للزرار والتفاعل

  // Background Colors
  static const Color backgroundPrimary = Color(0xFFFFFFFF); // أبيض
  static const Color backgroundSecondary = Color(0xFFFFF3E0); // بيج فاتح

  // Text Colors
  static const Color textHeading = Color(0xFF3E2723); // بني داكن للعناوين
  static const Color textBody = Color(0xFF5D4037); // بني متوسط للنص العادي

  // Error/Warning Colors
  static const Color error = Color(0xFFD32F2F); // أحمر تحذيري
  static const Color warning = Color(0xFFFF9800); // برتقالي تحذيري

  // Button States
  static const Color buttonPressed = Color(
    0xFFE64A19,
  ); // أغمق من Primary بنسبة 10%
  static const Color buttonDisabled = Color(0xFFBDBDBD); // رمادي للزر المعطل
  static const Color buttonDisabledText = Color(
    0xFF757575,
  ); // رمادي للنص المعطل

  // Card & Component Colors
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardShadow = Color(0x1F000000); // ظل خفيف

  // Icon Colors
  static const Color iconPrimary = Color(0xFF5D4037); // لون الأيقونة الأساسي
  static const Color iconAccent = Color(0xFFFFA726); // لون الأيقونة عند التفاعل

  // Divider Colors
  static const Color divider = Color(0xFFE0E0E0); // رمادي فاتح للفواصل

  // Success Colors
  static const Color success = Color(0xFF4CAF50); // أخضر للنجاح
  static const Color successLight = Color(0xFF81C784); // أخضر فاتح

  // Info Colors
  static const Color info = Color(0xFF2196F3); // أزرق للمعلومات
  static const Color infoLight = Color(0xFF64B5F6); // أزرق فاتح
}

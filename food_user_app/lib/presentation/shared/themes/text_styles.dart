import 'package:flutter/material.dart';
import 'colors.dart';

/// أنماط النصوص للتطبيق - Sahtin Typography
class AppTextStyles {
  // Font Families
  static const String fontFamilyHeading = 'Cairo';
  static const String fontFamilyBody = 'Roboto';

  // Font Weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // Heading Styles
  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 32,
    fontWeight: bold,
    color: AppColors.textHeading,
    height: 1.2,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 24,
    fontWeight: semiBold,
    color: AppColors.textHeading,
    height: 1.3,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 20,
    fontWeight: medium,
    color: AppColors.textHeading,
    height: 1.4,
  );

  static const TextStyle heading4 = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 18,
    fontWeight: medium,
    color: AppColors.textHeading,
    height: 1.4,
  );

  // Body Text Styles
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 18,
    fontWeight: regular,
    color: AppColors.textBody,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 16,
    fontWeight: regular,
    color: AppColors.textBody,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 14,
    fontWeight: regular,
    color: AppColors.textBody,
    height: 1.4,
  );

  // Caption Styles
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 12,
    fontWeight: light,
    color: AppColors.textBody,
    height: 1.3,
  );

  static const TextStyle captionSmall = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 10,
    fontWeight: light,
    color: AppColors.textBody,
    height: 1.2,
  );

  // Button Text Styles
  static const TextStyle buttonText = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 16,
    fontWeight: medium,
    color: Colors.white,
    height: 1.2,
  );

  static const TextStyle buttonTextSmall = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 14,
    fontWeight: medium,
    color: Colors.white,
    height: 1.2,
  );

  // Label Styles
  static const TextStyle label = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 14,
    fontWeight: medium,
    color: AppColors.textBody,
    height: 1.3,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 12,
    fontWeight: medium,
    color: AppColors.textBody,
    height: 1.2,
  );

  // Price Styles
  static const TextStyle price = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 18,
    fontWeight: bold,
    color: AppColors.primary,
    height: 1.2,
  );

  static const TextStyle priceSmall = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 16,
    fontWeight: bold,
    color: AppColors.primary,
    height: 1.2,
  );

  // Error Text Styles
  static const TextStyle errorText = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 12,
    fontWeight: regular,
    color: AppColors.error,
    height: 1.3,
  );

  // Success Text Styles
  static const TextStyle successText = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 14,
    fontWeight: medium,
    color: AppColors.success,
    height: 1.3,
  );
}

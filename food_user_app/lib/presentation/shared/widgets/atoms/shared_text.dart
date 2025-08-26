import 'package:flutter/material.dart';
import '../../themes/text_styles.dart';
import '../../themes/colors.dart';

/// أنواع النصوص المتاحة
enum TextType {
  heading1,
  heading2,
  heading3,
  heading4,
  bodyLarge,
  bodyMedium,
  bodySmall,
  caption,
  captionSmall,
  button,
  buttonSmall,
  label,
  labelSmall,
  price,
  priceSmall,
  error,
  success,
}

/// نصوص مشتركة للتطبيق - Sahtin Shared Text
class SharedText extends StatelessWidget {
  final String text;
  final TextType type;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool softWrap;
  final double? height;
  final FontWeight? fontWeight;
  final double? fontSize;

  const SharedText({
    super.key,
    required this.text,
    this.type = TextType.bodyMedium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap = true,
    this.height,
    this.fontWeight,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _getTextStyle(),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  TextStyle _getTextStyle() {
    TextStyle baseStyle = _getBaseStyle();

    return baseStyle.copyWith(
      color: color,
      height: height,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }

  TextStyle _getBaseStyle() {
    switch (type) {
      case TextType.heading1:
        return AppTextStyles.heading1;
      case TextType.heading2:
        return AppTextStyles.heading2;
      case TextType.heading3:
        return AppTextStyles.heading3;
      case TextType.heading4:
        return AppTextStyles.heading4;
      case TextType.bodyLarge:
        return AppTextStyles.bodyLarge;
      case TextType.bodyMedium:
        return AppTextStyles.bodyMedium;
      case TextType.bodySmall:
        return AppTextStyles.bodySmall;
      case TextType.caption:
        return AppTextStyles.caption;
      case TextType.captionSmall:
        return AppTextStyles.captionSmall;
      case TextType.button:
        return AppTextStyles.buttonText;
      case TextType.buttonSmall:
        return AppTextStyles.buttonTextSmall;
      case TextType.label:
        return AppTextStyles.label;
      case TextType.labelSmall:
        return AppTextStyles.labelSmall;
      case TextType.price:
        return AppTextStyles.price;
      case TextType.priceSmall:
        return AppTextStyles.priceSmall;
      case TextType.error:
        return AppTextStyles.errorText;
      case TextType.success:
        return AppTextStyles.successText;
    }
  }
}

/// نص العنوان الرئيسي
class SharedHeading extends StatelessWidget {
  final String text;
  final TextType type;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  const SharedHeading({
    super.key,
    required this.text,
    this.type = TextType.heading2,
    this.color,
    this.textAlign,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return SharedText(
      text: text,
      type: type,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

/// نص الجسم
class SharedBodyText extends StatelessWidget {
  final String text;
  final TextType type;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const SharedBodyText({
    super.key,
    required this.text,
    this.type = TextType.bodyMedium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return SharedText(
      text: text,
      type: type,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// نص السعر
class SharedPriceText extends StatelessWidget {
  final String price;
  final bool isSmall;
  final Color? color;
  final TextAlign? textAlign;

  const SharedPriceText({
    super.key,
    required this.price,
    this.isSmall = false,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return SharedText(
      text: price,
      type: isSmall ? TextType.priceSmall : TextType.price,
      color: color,
      textAlign: textAlign,
    );
  }
}

/// نص الخطأ
class SharedErrorText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final int? maxLines;

  const SharedErrorText({
    super.key,
    required this.text,
    this.textAlign,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return SharedText(
      text: text,
      type: TextType.error,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

/// نص النجاح
class SharedSuccessText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final int? maxLines;

  const SharedSuccessText({
    super.key,
    required this.text,
    this.textAlign,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return SharedText(
      text: text,
      type: TextType.success,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

/// نص التسمية
class SharedLabelText extends StatelessWidget {
  final String text;
  final bool isSmall;
  final Color? color;
  final TextAlign? textAlign;

  const SharedLabelText({
    super.key,
    required this.text,
    this.isSmall = false,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return SharedText(
      text: text,
      type: isSmall ? TextType.labelSmall : TextType.label,
      color: color,
      textAlign: textAlign,
    );
  }
}

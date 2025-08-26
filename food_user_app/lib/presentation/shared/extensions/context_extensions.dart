import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/text_styles.dart';

/// إضافات للـ BuildContext - Sahtin Context Extensions
extension ContextExtensions on BuildContext {
  /// الحصول على حجم الشاشة
  Size get screenSize => MediaQuery.of(this).size;

  /// الحصول على عرض الشاشة
  double get screenWidth => MediaQuery.of(this).size.width;

  /// الحصول على ارتفاع الشاشة
  double get screenHeight => MediaQuery.of(this).size.height;

  /// الحصول على نسبة البكسل
  double get pixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// التحقق من الاتجاه (RTL/LTR)
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;

  /// التحقق من الوضع المظلم
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// الحصول على الألوان
  AppColors get colors => AppColors();

  /// الحصول على أنماط النصوص
  AppTextStyles get textStyles => AppTextStyles();

  /// الحصول على النمط الحالي
  ThemeData get theme => Theme.of(this);

  /// الحصول على النمط الأساسي
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// الحصول على النمط النصي
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// التنقل إلى شاشة جديدة
  Future<T?> navigateTo<T>(Widget screen) {
    return Navigator.of(
      this,
    ).push<T>(MaterialPageRoute<T>(builder: (context) => screen));
  }

  /// التنقل إلى شاشة جديدة واستبدال الشاشة الحالية
  Future<T?> navigateToReplacement<T>(Widget screen) {
    return Navigator.of(this).pushReplacement<T, void>(
      MaterialPageRoute<T>(builder: (context) => screen),
    );
  }

  /// التنقل إلى شاشة جديدة وإزالة جميع الشاشات السابقة
  Future<T?> navigateToAndClear<T>(Widget screen) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      MaterialPageRoute<T>(builder: (context) => screen),
      (route) => false,
    );
  }

  /// العودة إلى الشاشة السابقة
  void goBack<T>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  /// التحقق من إمكانية العودة
  bool get canPop => Navigator.of(this).canPop();

  /// إظهار رسالة تأكيد
  Future<bool?> showConfirmDialog({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
  }) {
    return showDialog<bool>(
      context: this,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(cancelText ?? 'إلغاء'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(confirmText ?? 'تأكيد'),
              ),
            ],
          ),
    );
  }

  /// إظهار رسالة خطأ
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// إظهار رسالة نجاح
  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// إظهار رسالة تحذير
  void showWarningSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.warning,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// إظهار رسالة معلومات
  void showInfoSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.info,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// إخفاء لوحة المفاتيح
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  /// التحقق من وجود لوحة المفاتيح
  bool get isKeyboardVisible {
    return MediaQuery.of(this).viewInsets.bottom > 0;
  }

  /// الحصول على ارتفاع لوحة المفاتيح
  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;

  /// الحصول على حالة الاتصال
  bool get isConnected {
    // يمكن إضافة منطق للتحقق من الاتصال
    return true;
  }

  /// الحصول على نوع الجهاز
  DeviceType get deviceType {
    final width = screenWidth;
    if (width >= 1024) {
      return DeviceType.desktop;
    } else if (width >= 600) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }
}

/// أنواع الأجهزة
enum DeviceType { mobile, tablet, desktop }

import 'package:flutter/material.dart';
import 'login_mobile.dart';
import 'login_tablet.dart';
import 'login_web.dart';

/// شاشة تسجيل الدخول الرئيسية التي تختار العرض المناسب بناءً على حجم الشاشة
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // اختيار العرض المناسب بناءً على عرض الشاشة
    if (width >= 1024) {
      return const LoginWeb(); // واجهة الويب للشاشات الكبيرة
    } else if (width >= 600) {
      return const LoginTablet(); // واجهة الأجهزة اللوحية للشاشات المتوسطة
    } else {
      return const LoginMobile(); // واجهة الهاتف للشاشات الصغيرة
    }
  }
}

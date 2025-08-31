import 'package:easy_localization/easy_localization.dart';

String? validateEmail(String? value, context) {
  if (value == null || value.isEmpty) {
    return 'emailRequired'.tr();
  }
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return 'emailInvalid'.tr();
  }
  return null;
}

String? validatePassword(String? value, context) {
  if (value == null || value.isEmpty) {
    return 'passwordRequired'.tr();
  }
  if (value.length < 6) {
    return 'passwordTooShort'.tr();
  }
  return null;
}

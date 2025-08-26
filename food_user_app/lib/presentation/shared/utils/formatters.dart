import 'package:intl/intl.dart';

/// أدوات تنسيق النصوص والتواريخ والأرقام - Sahtin Formatters
class Formatters {
  static String formatPrice(num price) {
    return NumberFormat.currency(locale: 'ar', symbol: 'ر.س').format(price);
  }

  static String formatDate(DateTime date) {
    return DateFormat.yMMMMd('ar').format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat.Hm('ar').format(date);
  }
}

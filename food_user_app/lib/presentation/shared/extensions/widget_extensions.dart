import 'package:flutter/material.dart';

/// إضافات لعناصر الواجهة - Sahtin Widget Extensions
extension WidgetPaddingExtension on Widget {
  /// إضافة حشو (Padding) حول الودجت
  Widget withPadding([EdgeInsetsGeometry padding = const EdgeInsets.all(8)]) {
    return Padding(padding: padding, child: this);
  }

  /// إضافة هامش (Margin) حول الودجت باستخدام Container
  Widget withMargin([EdgeInsetsGeometry margin = const EdgeInsets.all(8)]) {
    return Container(margin: margin, child: this);
  }
}

extension WidgetVisibilityExtension on Widget {
  /// إخفاء الودجت بناءً على شرط
  Widget visible(bool isVisible) {
    return isVisible ? this : const SizedBox.shrink();
  }
}

extension WidgetExpandExtension on Widget {
  /// توسيع الودجت داخل Row/Column
  Widget expanded({int flex = 1}) {
    return Expanded(flex: flex, child: this);
  }

  /// توسيع الودجت داخل Flexible
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) {
    return Flexible(flex: flex, fit: fit, child: this);
  }
}

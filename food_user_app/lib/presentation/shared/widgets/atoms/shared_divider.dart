import 'package:flutter/material.dart';
import '../../themes/colors.dart';

/// فاصل مشترك - Sahtin Shared Divider
class SharedDivider extends StatelessWidget {
  final double thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;
  final Axis direction;
  final double? length;

  const SharedDivider({
    super.key,
    this.thickness = 1,
    this.indent,
    this.endIndent,
    this.color,
    this.direction = Axis.horizontal,
    this.length,
  });

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      return Divider(
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
        color: color ?? AppColors.divider,
        height: length,
      );
    } else {
      return VerticalDivider(
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
        color: color ?? AppColors.divider,
        width: length,
      );
    }
  }
}

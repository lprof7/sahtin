import 'package:flutter/material.dart';

/// مسافة مشتركة - Sahtin Shared Spacer
class SharedSpacer extends StatelessWidget {
  final double size;
  final Axis direction;

  /// [size] default is 8 (8px grid)
  const SharedSpacer({
    super.key,
    this.size = 8,
    this.direction = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      return SizedBox(width: size);
    } else {
      return SizedBox(height: size);
    }
  }
}

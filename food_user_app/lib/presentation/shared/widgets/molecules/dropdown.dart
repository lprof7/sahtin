import 'package:flutter/material.dart';
import '../../themes/text_styles.dart';

/// قائمة منسدلة مشتركة - Sahtin Shared Dropdown
class SharedDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemToString;
  final void Function(T?)? onChanged;
  final String? hint;
  final Widget? prefixIcon;
  final bool isExpanded;
  final bool enabled;

  const SharedDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.itemToString,
    this.onChanged,
    this.hint,
    this.prefixIcon,
    this.isExpanded = true,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      items:
          items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemToString(item), style: AppTextStyles.bodyMedium),
            );
          }).toList(),
      onChanged: enabled ? onChanged : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
      ),
      style: AppTextStyles.bodyMedium,
      isExpanded: isExpanded,
    );
  }
}

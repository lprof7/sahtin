import 'package:flutter/material.dart';
import '../../themes/colors.dart';
import '../../themes/text_styles.dart';

/// أنواع الأزرار المتاحة
enum ButtonType { elevated, outlined, text }

/// أزرار مشتركة للتطبيق - Sahtin Shared Buttons
class SharedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const SharedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.elevated,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final buttonWidget = _buildButtonWidget();

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: buttonWidget);
    }

    if (width != null || height != null) {
      return SizedBox(width: width, height: height, child: buttonWidget);
    }

    return buttonWidget;
  }

  Widget _buildButtonWidget() {
    switch (type) {
      case ButtonType.elevated:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: _buildButtonContent(),
        );

      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: _buildButtonContent(),
        );

      case ButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: _buildButtonContent(),
        );
    }
  }

  Widget _buildButtonContent() {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color:
                type == ButtonType.elevated ? Colors.white : AppColors.primary,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style:
                type == ButtonType.elevated
                    ? AppTextStyles.buttonText
                    : AppTextStyles.buttonText.copyWith(
                      color: AppColors.primary,
                    ),
          ),
        ],
      );
    }

    return Text(
      text,
      style:
          type == ButtonType.elevated
              ? AppTextStyles.buttonText
              : AppTextStyles.buttonText.copyWith(color: AppColors.primary),
    );
  }
}

/// زر صغير
class SharedSmallButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isLoading;
  final IconData? icon;

  const SharedSmallButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.elevated,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SharedButton(
      text: text,
      onPressed: onPressed,
      type: type,
      isLoading: isLoading,
      icon: icon,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}

/// زر دائري
class SharedIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool isLoading;

  const SharedIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 48,
    this.backgroundColor,
    this.iconColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: iconColor ?? Colors.white,
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        child:
            isLoading
                ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                : Icon(icon, size: size * 0.4),
      ),
    );
  }
}

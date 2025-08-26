import 'package:flutter/material.dart';
import '../../themes/text_styles.dart';
import '../../themes/colors.dart';

/// عنصر قائمة مشترك - Sahtin Shared List Item
class SharedListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;

  const SharedListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.enabled = true,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          fontWeight: AppTextStyles.medium,
        ),
      ),
      subtitle:
          subtitle != null
              ? Text(subtitle!, style: AppTextStyles.bodySmall)
              : null,
      leading: leading,
      trailing: trailing,
      onTap: enabled ? onTap : null,
      enabled: enabled,
      contentPadding: contentPadding,
    );
  }
}

/// عنصر قائمة مع صورة - Sahtin Shared List Item with Image
class SharedImageListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final Widget? trailing;
  final VoidCallback? onTap;
  final double imageSize;
  final BorderRadius? imageBorderRadius;

  const SharedImageListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.trailing,
    this.onTap,
    this.imageSize = 48,
    this.imageBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          fontWeight: AppTextStyles.medium,
        ),
      ),
      subtitle:
          subtitle != null
              ? Text(subtitle!, style: AppTextStyles.bodySmall)
              : null,
      leading: _buildLeading(),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildLeading() {
    if (imageUrl != null) {
      return ClipRRect(
        borderRadius: imageBorderRadius ?? BorderRadius.circular(8),
        child: Image.network(
          imageUrl!,
          width: imageSize,
          height: imageSize,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                color: AppColors.backgroundSecondary,
                borderRadius: imageBorderRadius ?? BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.image,
                size: imageSize * 0.5,
                color: AppColors.textBody,
              ),
            );
          },
        ),
      );
    }
    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: imageBorderRadius ?? BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.image,
        size: imageSize * 0.5,
        color: AppColors.textBody,
      ),
    );
  }
}

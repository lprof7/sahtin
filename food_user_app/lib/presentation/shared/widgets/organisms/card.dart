import 'package:flutter/material.dart';
import '../../themes/colors.dart';
import '../../themes/text_styles.dart';

/// بطاقة مشتركة - Sahtin Shared Card
class SharedCard extends StatelessWidget {
  final Widget? header;
  final Widget? content;
  final Widget? footer;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const SharedCard({
    super.key,
    this.header,
    this.content,
    this.footer,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget cardContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null) ...[
          header!,
          if (content != null || footer != null) const Divider(height: 1),
        ],
        if (content != null) ...[
          Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: content!,
          ),
        ],
        if (footer != null) ...[
          if (content != null) const Divider(height: 1),
          footer!,
        ],
      ],
    );

    if (onTap != null) {
      cardContent = InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: cardContent,
      );
    }

    return Card(
      margin: margin,
      color: backgroundColor ?? AppColors.cardBackground,
      elevation: elevation ?? 2,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      child: cardContent,
    );
  }
}

/// بطاقة طبق - Sahtin Dish Card
class SharedDishCard extends StatelessWidget {
  final String title;
  final String? description;
  final String? imageUrl;
  final String? price;
  final VoidCallback? onTap;
  final Widget? trailing;

  const SharedDishCard({
    super.key,
    required this.title,
    this.description,
    this.imageUrl,
    this.price,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return SharedCard(
      onTap: onTap,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl!,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundSecondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.restaurant,
                      size: 48,
                      color: AppColors.textBody,
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.heading4,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        description!,
                        style: AppTextStyles.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (price != null) ...[
                      const SizedBox(height: 8),
                      Text(price!, style: AppTextStyles.priceSmall),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[const SizedBox(width: 8), trailing!],
            ],
          ),
        ],
      ),
    );
  }
}

/// بطاقة قائمة - Sahtin Menu Card
class SharedMenuCard extends StatelessWidget {
  final String title;
  final String? description;
  final String? imageUrl;
  final List<String>? tags;
  final VoidCallback? onTap;

  const SharedMenuCard({
    super.key,
    required this.title,
    this.description,
    this.imageUrl,
    this.tags,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SharedCard(
      onTap: onTap,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl!,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundSecondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.menu_book,
                      size: 48,
                      color: AppColors.textBody,
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyles.heading3,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (description != null) ...[
            const SizedBox(height: 4),
            Text(
              description!,
              style: AppTextStyles.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (tags != null && tags!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children:
                  tags!.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tag,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

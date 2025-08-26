import 'package:flutter/material.dart';
import '../../themes/colors.dart';
import '../../themes/text_styles.dart';

/// قائمة جانبية - Sahtin Navigation Drawer
class SharedDrawer extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  final String? userImageUrl;
  final List<DrawerItem> items;
  final VoidCallback? onProfileTap;

  const SharedDrawer({
    super.key,
    this.userName,
    this.userEmail,
    this.userImageUrl,
    required this.items,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: Icon(item.icon, color: AppColors.iconPrimary),
                  title: Text(item.title, style: AppTextStyles.bodyMedium),
                  onTap: () {
                    Navigator.pop(context);
                    item.onTap?.call();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text(
        userName ?? 'مستخدم',
        style: AppTextStyles.bodyMedium.copyWith(
          color: Colors.white,
          fontWeight: AppTextStyles.medium,
        ),
      ),
      accountEmail: Text(
        userEmail ?? 'user@example.com',
        style: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundImage:
            userImageUrl != null ? NetworkImage(userImageUrl!) : null,
        child:
            userImageUrl == null
                ? const Icon(Icons.person, color: Colors.white)
                : null,
      ),
      onDetailsPressed: onProfileTap,
      decoration: const BoxDecoration(color: AppColors.primary),
    );
  }
}

/// عنصر القائمة الجانبية - Drawer Item
class DrawerItem {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const DrawerItem({required this.title, required this.icon, this.onTap});
}

/// عناصر القائمة الجانبية الافتراضية - Default Drawer Items
class DrawerItems {
  static const List<DrawerItem> defaultItems = [
    DrawerItem(title: 'الرئيسية', icon: Icons.home),
    DrawerItem(title: 'القوائم', icon: Icons.restaurant_menu),
    DrawerItem(title: 'السلة', icon: Icons.shopping_cart),
    DrawerItem(title: 'الطلبات', icon: Icons.receipt),
    DrawerItem(title: 'الإعدادات', icon: Icons.settings),
    DrawerItem(title: 'المساعدة', icon: Icons.help),
  ];
}

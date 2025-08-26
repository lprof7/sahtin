import 'package:flutter/material.dart';
import '../../themes/colors.dart';

/// شريط التنقل السفلي - Sahtin Bottom Navigation Bar
class SharedBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> items;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  const SharedBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
      backgroundColor: backgroundColor ?? AppColors.backgroundPrimary,
      selectedItemColor: selectedItemColor ?? AppColors.primary,
      unselectedItemColor: unselectedItemColor ?? AppColors.textBody,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    );
  }
}

/// عناصر شريط التنقل الافتراضية - Default Bottom Nav Items
class BottomNavItems {
  static const List<BottomNavigationBarItem> defaultItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
    BottomNavigationBarItem(
      icon: Icon(Icons.restaurant_menu),
      label: 'القوائم',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'السلة'),
    BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'الطلبات'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الملف الشخصي'),
  ];
}

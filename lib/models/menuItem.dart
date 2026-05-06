import 'package:flutter/material.dart';

class MenuItemModel {
  final String title;
  final IconData icon;
  final String route;
  final bool isLogout;
  final VoidCallback? onTap; // هذا سيسمح لنا بتنفيذ دالة مخصصة عند الضغط

  MenuItemModel({
    required this.title,
    required this.icon,
    required this.route,
    this.isLogout = false,
    this.onTap,
  });
}

final List<MenuItemModel> menuItems = [
  MenuItemModel(
    title: "my_bookings",
    icon: Icons.calendar_month_outlined,
    route: "/bookings",
  ),
  MenuItemModel(
    title: "language", // مفتاح الترجمة الذي أضفناه سابقاً
    icon: Icons.translate_rounded,
    route: "", // لا نحتاج مسار هنا لأننا سنستخدم onTap
  ),
  MenuItemModel(
    title: "menu_logout",
    icon: Icons.logout_rounded,
    route: "logout",
    isLogout: true,
  ),
];

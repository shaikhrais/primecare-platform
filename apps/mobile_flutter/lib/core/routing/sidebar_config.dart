import 'package:flutter/material.dart';

class SidebarConfig {
  final Color activeColor;
  final List<String> paths;
  final List<BottomNavigationBarItem> items;

  const SidebarConfig({
    required this.activeColor,
    required this.paths,
    required this.items,
  });
}

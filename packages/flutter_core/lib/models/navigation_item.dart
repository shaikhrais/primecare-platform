import 'package:flutter/material.dart';

class PrimeCareNavigationItem {
  final String label;
  final IconData icon;
  final String route;
  final IconData? activeIcon;

  const PrimeCareNavigationItem({
    required this.label,
    required this.icon,
    required this.route,
    this.activeIcon,
  });
}

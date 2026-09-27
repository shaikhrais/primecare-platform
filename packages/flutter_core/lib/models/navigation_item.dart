// Governance - Category: model | Purpose: Layer: 01_INFRASTRUCTURE
// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';

class PrimeCareNavigationItem {
  final String label;
  final IconData icon;
  final String route;
  final String? section;
  final IconData? activeIcon;

  const PrimeCareNavigationItem({
    required this.label,
    required this.icon,
    required this.route,
    this.section,
    this.activeIcon,
  });
}

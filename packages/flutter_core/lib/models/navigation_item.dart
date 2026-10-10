// Flutter icon adapter for the shared navigation contract.
import 'package:flutter/material.dart';
import 'package:primecare_models/primecare_models.dart' show BaseNavigationItem;

class PrimeCareNavigationItem extends BaseNavigationItem<IconData> {
  const PrimeCareNavigationItem({
    required super.label,
    required super.icon,
    required super.route,
    super.section,
    super.activeIcon,
  });
}

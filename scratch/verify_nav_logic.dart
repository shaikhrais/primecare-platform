
import 'package:flutter/material.dart';

enum PlatformRole { ceo, coo, corporate, admin }

abstract class PrimeCareScreen {
  final String title;
  final PlatformRole? requiredRole;
  PrimeCareScreen({required this.title, this.requiredRole});
}

class Screen extends PrimeCareScreen {
  Screen({required super.title, super.requiredRole});
}

void main() {
  final screens = [
    Screen(title: 'CEO Dashboard', requiredRole: PlatformRole.ceo),
    Screen(title: 'COO Dashboard', requiredRole: PlatformRole.coo),
  ];

  final activeRole = PlatformRole.ceo;

  final filtered = screens.where((screen) =>
      screen.requiredRole == null || screen.requiredRole == activeRole).toList();

  print('Active Role: $activeRole');
  print('Filtered Screens: ${filtered.map((s) => s.title).toList()}');

  if (filtered.length == 1 && filtered[0].title == 'CEO Dashboard') {
    print('Logic is CORRECT');
  } else {
    print('Logic is WRONG: ${filtered.length} items found');
  }
}

import 'package:flutter/material.dart';

/// A boundary marker used to enforce that screens are rendered within a master layout shell.
class AppShellBoundary extends InheritedWidget {
  const AppShellBoundary({super.key, required super.child});

  static bool isActive(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppShellBoundary>() !=
        null;
  }

  @override
  bool updateShouldNotify(AppShellBoundary oldWidget) => false;
}


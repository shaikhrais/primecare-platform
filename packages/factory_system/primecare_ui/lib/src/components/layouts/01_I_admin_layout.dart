// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/components/layouts/01_I_base_layout_shell.dart';

class AdminLayout extends StatelessWidget {
  final Widget child;
  final String? currentPath;
  final List<Widget>? topBarActions;
  final Widget? customTopBarLeft;
  final Widget? customTopBarCenter;
  final Widget? customTopBarRight;

  const AdminLayout({
    super.key,
    required this.child,
    this.currentPath,
    this.topBarActions,
    this.customTopBarLeft,
    this.customTopBarCenter,
    this.customTopBarRight,
  });

  @override
  Widget build(BuildContext context) {
    return BaseLayoutShell(
      currentPath: currentPath,
      topBarActions: topBarActions,
      customTopBarLeft: customTopBarLeft,
      customTopBarCenter: customTopBarCenter,
      customTopBarRight: customTopBarRight,
      child: child,
    );
  }
}

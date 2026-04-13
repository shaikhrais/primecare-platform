import 'package:flutter/material.dart';
import 'base_layout_shell.dart';

class AdminLayout extends StatelessWidget {
  final Widget child;
  final String? currentPath;

  const AdminLayout({
    super.key,
    required this.child,
    this.currentPath,
  });

  @override
  Widget build(BuildContext context) {
    return BaseLayoutShell(
      currentPath: currentPath,
      child: child,
    );
  }
}

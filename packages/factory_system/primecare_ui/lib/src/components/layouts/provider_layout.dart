import 'package:flutter/material.dart';
import 'base_layout_shell.dart';

class ProviderLayout extends StatelessWidget {
  final Widget child;
  final String? currentPath;

  const ProviderLayout({
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

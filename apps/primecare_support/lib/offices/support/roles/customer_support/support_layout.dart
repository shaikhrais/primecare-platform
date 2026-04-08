import 'package:flutter/material.dart';
import 'package:primecare_ui/src/components/layouts/master_layout.dart';

class SupportLayout extends StatelessWidget {
  final Widget child;
  const SupportLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MasterLayout(shellType: AppShellType.provider, child: child);
  }
}

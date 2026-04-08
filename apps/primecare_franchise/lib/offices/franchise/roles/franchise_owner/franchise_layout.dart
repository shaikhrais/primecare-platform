import 'package:flutter/material.dart';
import 'package:primecare_ui/src/components/layouts/master_layout.dart';

class FranchiseLayout extends StatelessWidget {
  final Widget child;
  const FranchiseLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MasterLayout(shellType: AppShellType.provider, child: child);
  }
}

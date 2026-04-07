import 'package:flutter/material.dart';
import '../../../../components/layouts/master_layout.dart';

class OntarioLayout extends StatelessWidget {
  final Widget child;
  const OntarioLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MasterLayout(shellType: AppShellType.provider, child: child);
  }
}

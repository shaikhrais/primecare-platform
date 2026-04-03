import 'package:flutter/material.dart';
import '../../../../components/layouts/master_layout.dart';

class RmtLayout extends StatelessWidget {
  final Widget child;
  const RmtLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MasterLayout(
      shellType: AppShellType.provider,
      child: child,
    );
  }
}

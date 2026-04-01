import 'package:flutter/material.dart';
import '../../../../components/layouts/master_layout.dart';

class CeoLayout extends StatelessWidget {
  final Widget child;
  const CeoLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasterLayout(
      shellType: AppShellType.provider,
      child: child,
    );
  }
}

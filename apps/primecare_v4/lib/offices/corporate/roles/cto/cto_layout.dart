import 'package:flutter/material.dart';
import '../../../../components/layouts/master_layout.dart';

class CtoLayout extends StatelessWidget {
  final Widget child;
  const CtoLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasterLayout(
      shellType: AppShellType.provider,
      child: child,
    );
  }
}

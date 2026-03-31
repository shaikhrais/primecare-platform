import 'package:flutter/material.dart';
import 'sidebar_layout.dart';
import 'top_bar_layout.dart';

class MasterLayout extends StatelessWidget {
  final Widget child;
  const MasterLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBarLayout(),
      body: Row(
        children: [
          const SidebarLayout(),
          Expanded(child: child),
        ],
      ),
    );
  }
}

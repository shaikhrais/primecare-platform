import 'package:flutter/material.dart';

class SidebarLayout extends StatelessWidget {
  const SidebarLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Theme.of(context).colorScheme.surface,
      child: ListView(
        children: const [
          ListTile(title: Text('Menu Item 1')),
          ListTile(title: Text('Common Dashboard')),
        ],
      ),
    );
  }
}

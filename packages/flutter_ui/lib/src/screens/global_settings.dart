import 'package:flutter/material.dart';

class GlobalSettings extends StatelessWidget {
  const GlobalSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Global Settings')),
      body: ListView(
        children: const [
          ListTile(title: Text('Account Settings')),
          ListTile(title: Text('Notifications')),
          ListTile(title: Text('Security privacy')),
        ],
      ),
    );
  }
}

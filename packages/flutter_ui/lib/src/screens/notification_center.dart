import 'package:flutter/material.dart';

class NotificationCenter extends StatelessWidget {
  const NotificationCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Center')),
      body: ListView(
        children: const [
          ListTile(leading: Icon(Icons.notifications), title: Text('System Update Completed')),
          ListTile(leading: Icon(Icons.notifications), title: Text('New Patient Registered')),
        ],
      ),
    );
  }
}

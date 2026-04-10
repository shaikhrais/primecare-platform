import 'package:flutter/material.dart';

class MessagingHub extends StatelessWidget {
  const MessagingHub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messaging Hub')),
      body: ListView(
        children: const [
          ListTile(leading: Icon(Icons.message), title: Text('Recent Message')),
        ],
      ),
    );
  }
}

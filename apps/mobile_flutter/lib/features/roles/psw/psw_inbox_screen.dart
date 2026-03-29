import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswInboxScreen extends StatelessWidget {
  const PswInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: PrimeCareAppBar(title: 'Secure Inbox'),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              children: [
                ListTile(title: Text('Message Thread 1')),
                ListTile(title: Text('Message Thread 2')),
              ],
            ),
          ),
          VerticalDivider(width: 1),
          Expanded(
            flex: 2,
            child: Center(child: Text('Select a thread')),
          )
        ],
      ),
    );
  }
}

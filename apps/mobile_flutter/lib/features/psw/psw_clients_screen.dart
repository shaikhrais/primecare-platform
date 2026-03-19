import 'package:flutter/material.dart';

class PswClientsScreen extends StatelessWidget {
  const PswClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.people_alt, size: 64, color: Color(0xFFCBD5E1)),
            SizedBox(height: 16),
            Text('No Clients Assigned', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }
}

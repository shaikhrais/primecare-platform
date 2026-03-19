import 'package:flutter/material.dart';

class PswDashboardScreen extends StatelessWidget {
  const PswDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: const [BoxShadow(color: Color(0x05000000), blurRadius: 4, offset: Offset(0, 2))],
              ),
              child: const Column(
                children: [
                  Icon(Icons.event_available, size: 48, color: Color(0xFF0EA5E9)),
                  SizedBox(height: 12),
                  Text('No Upcoming Shifts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                  SizedBox(height: 8),
                  Text('You have zero active assignments scheduled for today.', style: TextStyle(color: Color(0xFF64748B)), textAlign: TextAlign.center),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

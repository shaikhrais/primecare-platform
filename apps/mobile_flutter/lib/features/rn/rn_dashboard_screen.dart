import 'package:flutter/material.dart';

class RnDashboardScreen extends StatelessWidget {
  const RnDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Clinical Hub',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pending Assessments & Care Plan Updates',
              style: TextStyle(fontSize: 16, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.fact_check, size: 64, color: Color(0xFF94A3B8)),
                    SizedBox(height: 16),
                    Text('All clinical quotas met for today.', style: TextStyle(color: Color(0xFF64748B))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

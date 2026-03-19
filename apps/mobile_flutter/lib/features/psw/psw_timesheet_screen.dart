import 'package:flutter/material.dart';

class PswTimesheetScreen extends StatelessWidget {
  const PswTimesheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Total Earnings This Week', style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
              SizedBox(height: 4),
              Text('\$0.00', style: TextStyle(color: Color(0xFF0F172A), fontSize: 36, fontWeight: FontWeight.w800)),
              Divider(height: 32),
              Text('0.0 Total Hours Logged', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF10B981))),
            ],
          ),
        ),
      ),
    );
  }
}

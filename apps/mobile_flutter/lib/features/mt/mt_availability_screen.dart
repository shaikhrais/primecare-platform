import 'package:flutter/material.dart';

class MtAvailabilityScreen extends StatelessWidget {
  const MtAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Text('MY JANE AVAILABILITY', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
              const SizedBox(height: 24),
              const Text('Use this panel to literally restrict PrimeCare Coordinators from executing drag-and-drop bookings onto your grid.', style: TextStyle(color: Color(0xFF475569), height: 1.5)),
              const SizedBox(height: 32),
              _buildDayToggle('Monday', '9:00 AM - 5:00 PM', true),
              _buildDayToggle('Tuesday', '9:00 AM - 5:00 PM', true),
              _buildDayToggle('Wednesday', 'Blocked / Offline', false),
              _buildDayToggle('Thursday', '12:00 PM - 8:00 PM', true),
              _buildDayToggle('Friday', '9:00 AM - 5:00 PM', true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayToggle(String day, String bounds, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: isActive ? const Color(0xFFDBEAFE) : const Color(0xFFE2E8F0)), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(day, style: TextStyle(fontWeight: FontWeight.w900, color: isActive ? const Color(0xFF2563EB) : const Color(0xFF64748B), fontSize: 16)),
              Text(bounds, style: TextStyle(color: isActive ? const Color(0xFF0F172A) : const Color(0xFF94A3B8), fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
          Switch(value: isActive, onChanged: (v){}, activeColor: const Color(0xFF2563EB)),
        ],
      ),
    );
  }
}

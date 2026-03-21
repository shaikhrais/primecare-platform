import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class MtAvailabilityScreen extends StatelessWidget {
  const MtAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareListView(
            padding: const EdgeInsets.all(24),
            children: [
              const PrimeCareText('MY JANE AVAILABILITY', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: PrimeCareColors.radarDark)),
              const PrimeCareSizedBox(height: 24),
              const PrimeCareText('Use this panel to literally restrict PrimeCare Coordinators from executing drag-and-drop bookings onto your grid.', style: TextStyle(color: Color(0xFF475569), height: 1.5)),
              const PrimeCareSizedBox(height: 32),
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
    return PrimeCareCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      
      child: PrimeCareRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimeCareText(day, style: TextStyle(fontWeight: FontWeight.w900, color: isActive ? const Color(0xFF2563EB) : PrimeCareColors.slate500, fontSize: 16)),
              PrimeCareText(bounds, style: TextStyle(color: isActive ? PrimeCareColors.radarDark : PrimeCareColors.slate400, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
          Switch(value: isActive, onChanged: (v){}, activeColor: const Color(0xFF2563EB)),
        ],
      ),
    );
  }
}

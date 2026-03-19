import 'package:flutter/material.dart';
import '../../core/widgets/primecare_app_bar.dart';

class PswTimesheetDetailScreen extends StatelessWidget {
  final String date;
  final double earnings;
  final bool surgeActive;

  const PswTimesheetDetailScreen({
    super.key,
    required this.date,
    required this.earnings,
    required this.surgeActive
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: PrimeCareAppBar(title: '$date Shift Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Macro Earnings Payout Calculation Graphic
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 16, offset: Offset(0, 4))],
              ),
              child: Column(
                children: [
                  const Text('Gross Daily Earnings', style: TextStyle(color: Color(0xFF64748B), fontSize: 16)),
                  const SizedBox(height: 12),
                  Text('\$${earnings.toStringAsFixed(2)}', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -1)),
                  
                  if (surgeActive) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0x1110B981),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bolt_rounded, color: Color(0xFF10B981), size: 20),
                          SizedBox(width: 8),
                          Text('High Demand Surge Active (+1.5x)', style: TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.bold)),
                        ],
                      )
                    )
                  ],
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Tax Simulator Breakdown Widget
            const Text('NET TAKEHOME CALCULATION', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1.5)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  _buildLineItem('Base Pay (8h x \$25.00)', '\$200.00'),
                  const SizedBox(height: 12),
                  _buildLineItem('Surge OT (2.5h x \$37.50)', '\$93.75'),
                  const SizedBox(height: 12),
                  _buildLineItem('Travel Stipend (14km)', '\$21.25'),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(color: Color(0xFFE2E8F0)),
                  ),
                  _buildLineItem('Est. Target Pre-Tax', '\$315.00', bold: true),
                  const SizedBox(height: 12),
                  _buildLineItem('- Federal Deductions (15%)', '-\$47.25', color: const Color(0xFFE11D48)),
                  _buildLineItem('- CPP Contributions (2%)', '-\$6.30', color: const Color(0xFFE11D48)),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // EVV GPS Logging Verification Node
            const Text('TELEMETRY GPS LOGS', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1.5)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  _buildGpsLog('CLOCK IN', '10:04:12 AM', 'Lat 43.65, Lon -79.38 • Accuracy 4m', true),
                  Container(
                    margin: const EdgeInsets.only(left: 17),
                    height: 32, width: 2, 
                    color: const Color(0xFFE2E8F0), 
                    alignment: Alignment.centerLeft
                  ),
                  _buildGpsLog('CLOCK OUT', '08:34:55 PM', 'Lat 43.65, Lon -79.38 • Accuracy 6m', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineItem(String label, String amount, {bool bold = false, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 15, fontWeight: bold ? FontWeight.bold : FontWeight.normal, color: color ?? const Color(0xFF475569))),
        Text(amount, style: TextStyle(fontSize: 15, fontWeight: bold ? FontWeight.bold : FontWeight.w600, color: color ?? const Color(0xFF0F172A))),
      ],
    );
  }

  Widget _buildGpsLog(String type, String time, String geo, bool isStart) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(isStart ? Icons.gps_fixed : Icons.exit_to_app_rounded, color: isStart ? const Color(0xFF10B981) : const Color(0xFF3B82F6), size: 36),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(type, style: TextStyle(color: isStart ? const Color(0xFF10B981) : const Color(0xFF3B82F6), fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1)),
            const SizedBox(height: 4),
            Text(time, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF0F172A))),
            const SizedBox(height: 4),
            Text(geo, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13, fontFamily: 'monospace')),
          ],
        )
      ],
    );
  }
}

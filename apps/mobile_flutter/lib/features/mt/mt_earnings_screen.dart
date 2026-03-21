import 'package:flutter/material.dart';
import '../shared/layouts/desktop_pane_wrapper.dart';

class MtEarningsScreen extends StatelessWidget {
  const MtEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: DesktopPaneWrapper(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Text('PAYROLL & SPLITS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)]), borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Next Payout (Oct 15)', style: TextStyle(color: Color(0xFFDDD6FE), fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('\$2,450.00', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white)),
                    const SizedBox(height: 8),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: const Color(0x33FFFFFF), borderRadius: BorderRadius.circular(8)), child: const Text('MT Revenue Split: 65%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('TRANSACTION HISTORY', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              const SizedBox(height: 16),
              _buildEarningRow('Oct 10', 'Arthur Pendelton (Deep Tissue)', '\$94.25'),
              _buildEarningRow('Oct 10', 'Emily Watson (Swedish)', '\$68.50'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEarningRow(String date, String desc, String splitAmount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFE2E8F0)), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(desc, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              Text(date, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
            ],
          ),
          Text(splitAmount, style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF10B981), fontSize: 16)),
        ],
      ),
    );
  }
}

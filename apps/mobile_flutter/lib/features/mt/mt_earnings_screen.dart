import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class MtEarningsScreen extends StatelessWidget {
  const MtEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareListView(
            padding: const EdgeInsets.all(24),
            children: [
              const PrimeCareText('PAYROLL & SPLITS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: PrimeCareColors.radarDark)),
              const PrimeCareSizedBox(height: 24),
              PrimeCareCard(
                padding: const EdgeInsets.all(24),
                
                child: PrimeCareColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PrimeCareText('Next Payout (Oct 15)', style: TextStyle(color: Color(0xFFDDD6FE), fontWeight: FontWeight.bold)),
                    const PrimeCareSizedBox(height: 8),
                    const PrimeCareText('\$2,450.00', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white)),
                    const PrimeCareSizedBox(height: 8),
                    PrimeCareCard(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),  child: const PrimeCareText('MT Revenue Split: 65%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                  ],
                ),
              ),
              const PrimeCareSizedBox(height: 24),
              const PrimeCareText('TRANSACTION HISTORY', style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              const PrimeCareSizedBox(height: 16),
              _buildEarningRow('Oct 10', 'Arthur Pendelton (Deep Tissue)', '\$94.25'),
              _buildEarningRow('Oct 10', 'Emily Watson (Swedish)', '\$68.50'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEarningRow(String date, String desc, String splitAmount) {
    return PrimeCareCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      
      child: PrimeCareRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimeCareText(desc, style: const TextStyle(fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
              PrimeCareText(date, style: const TextStyle(color: PrimeCareColors.slate500, fontSize: 12)),
            ],
          ),
          PrimeCareText(splitAmount, style: const TextStyle(fontWeight: FontWeight.w900, color: PrimeCareColors.emerald, fontSize: 16)),
        ],
      ),
    );
  }
}

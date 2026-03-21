import 'package:flutter/material.dart';
import '../../core/colors.dart';
import 'package:primecare_ui/primecare_ui.dart';


class GmFinancialsScreen extends StatelessWidget {
  const GmFinancialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: PrimeCareColors.radarDark,
      appBar: PrimeCareNavBar(
        title: const PrimeCareText('Double-Entry Ledger', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: PrimeCareColors.darkMatrix,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 800;

          final cashCard = PrimeCareCard(
            padding: const EdgeInsets.all(32),
            
            child: PrimeCareColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PrimeCareText('TOTAL CASH ASSETS', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                const PrimeCareSizedBox(height: 12),
                const PrimeCareText('\$142,590.00', style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w900)),
                const PrimeCareSizedBox(height: 24),
                PrimeCareRow(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    PrimeCareText('Liabilities: \$14,200', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
                    PrimeCareText('Equity: \$128,390', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
                  ],
                )
              ],
            ),
          );

          final recentEntries = PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PrimeCareText('RECENT JOURNAL ENTRIES', style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              const PrimeCareSizedBox(height: 16),
              _buildJournalLine('Shift Revenue Realized', 'Credit', '+\$240.00', 'Today, 2:14 PM'),
              _buildJournalLine('Surge Payroll Dispersed', 'Debit', '-\$38.50', 'Today, 2:14 PM'),
              _buildJournalLine('Cloudflare Services Billed', 'Debit', '-\$5.00', 'Yesterday'),
              _buildJournalLine('AWS Server Outage Credit', 'Credit', '+\$14.20', 'Yesterday'),
            ],
          );

          if (isDesktop) {
            return PrimeCareRow(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimeCareExpanded(child: PrimeCareListView(padding: const EdgeInsets.all(40), children: [cashCard])),
                PrimeCareContainer(width: 1, color: PrimeCareColors.slate800),
                PrimeCareExpanded(child: PrimeCareListView(padding: const EdgeInsets.all(40), children: [recentEntries])),
              ],
            );
          }

          return PrimeCareListView(
            padding: const EdgeInsets.all(20),
            children: [
              cashCard,
              const PrimeCareSizedBox(height: 32),
              recentEntries,
            ],
          );
        },
      ),
    );
  }

  Widget _buildJournalLine(String memo, String type, String amount, String date) {
    final isCredit = type == 'Credit';
    return PrimeCareCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      
      child: PrimeCareRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimeCareText(memo, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              const PrimeCareSizedBox(height: 4),
              PrimeCareText(date, style: const TextStyle(color: PrimeCareColors.slate500, fontSize: 12)),
            ],
          ),
          PrimeCareText(amount, style: TextStyle(color: isCredit ? PrimeCareColors.emerald : PrimeCareColors.rose, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}

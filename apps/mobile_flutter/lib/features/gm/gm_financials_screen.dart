import 'package:flutter/material.dart';

class GmFinancialsScreen extends StatelessWidget {
  const GmFinancialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('Double-Entry Ledger', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF020617),
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFF59E0B), Color(0xFFD97706)]),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: const Color(0xFFF59E0B).withAlpha(50), blurRadius: 20, offset: const Offset(0, 10))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('TOTAL CASH ASSETS', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('\$142,590.00', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Liabilities: \$14,200', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                    Text('Equity: \$128,390', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text('RECENT JOURNAL ENTRIES', style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold, letterSpacing: 1.5)),
          const SizedBox(height: 12),
          _buildJournalLine('Shift Revenue Realized', 'Credit', '+\$240.00', 'Today, 2:14 PM'),
          _buildJournalLine('Surge Payroll Dispersed', 'Debit', '-\$38.50', 'Today, 2:14 PM'),
          _buildJournalLine('Cloudflare Services Billed', 'Debit', '-\$5.00', 'Yesterday'),
        ],
      )
        ),
      ),
    );
  }

  Widget _buildJournalLine(String memo, String type, String amount, String date) {
    final isCredit = type == 'Credit';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(memo, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(date, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
            ],
          ),
          Text(amount, style: TextStyle(color: isCredit ? const Color(0xFF10B981) : const Color(0xFFE11D48), fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}

import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:flutter/material.dart';

class NurseDashboardSummaryCardsSection extends StatelessWidget {
  const NurseDashboardSummaryCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('nurse_dashboard_summary_cards-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          PrimeText('Summary Cards Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}

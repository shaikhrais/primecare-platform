import 'package:flutter/material.dart';

class FranchiseOwnerDashboardSummaryCardsSection extends StatelessWidget {
  const FranchiseOwnerDashboardSummaryCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('franchise_owner_dashboard_summary_cards-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Summary Cards Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TherapistDashboardSummaryCardsSection extends StatelessWidget {
  const TherapistDashboardSummaryCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('therapist_dashboard_summary_cards-section'),
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

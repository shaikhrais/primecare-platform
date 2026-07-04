import 'package:flutter/material.dart';

class HrManagerAnalyticsMetricsSummarySection extends StatelessWidget {
  const HrManagerAnalyticsMetricsSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('hr_manager_analytics_metrics_summary-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Metrics Summary Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}

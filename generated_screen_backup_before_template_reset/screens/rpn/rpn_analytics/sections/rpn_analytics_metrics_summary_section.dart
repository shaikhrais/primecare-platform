import 'package:flutter/material.dart';

class RpnAnalyticsMetricsSummarySection extends StatelessWidget {
  const RpnAnalyticsMetricsSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('rpn_analytics_metrics_summary-section'),
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

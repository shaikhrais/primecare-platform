import 'package:flutter/material.dart';

class FranchiseSalesManagerAnalyticsMetricsSummarySection extends StatelessWidget {
  final Map<String, dynamic> data;
  const FranchiseSalesManagerAnalyticsMetricsSummarySection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'franchise_sales_manager_analytics_metrics_summary_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Metrics Summary Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

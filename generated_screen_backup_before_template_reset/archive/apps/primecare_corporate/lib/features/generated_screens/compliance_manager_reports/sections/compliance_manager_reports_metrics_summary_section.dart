import 'package:flutter/material.dart';

class ComplianceManagerReportsMetricsSummarySection extends StatelessWidget {
  const ComplianceManagerReportsMetricsSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('compliance_manager_reports_metrics_summary-section'),
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

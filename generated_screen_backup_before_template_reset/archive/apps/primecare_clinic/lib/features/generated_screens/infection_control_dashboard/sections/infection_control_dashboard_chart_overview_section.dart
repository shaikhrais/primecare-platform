import 'package:flutter/material.dart';

class InfectionControlDashboardChartOverviewSection extends StatelessWidget {
  const InfectionControlDashboardChartOverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('infection_control_dashboard_chart_overview-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Chart Overview Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}

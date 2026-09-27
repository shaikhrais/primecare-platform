import 'package:flutter/material.dart';

class HrManagerAnalyticsExportActionsSection extends StatelessWidget {
  const HrManagerAnalyticsExportActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('hr_manager_analytics_export_actions-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Export Actions Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}

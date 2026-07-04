import 'package:flutter/material.dart';

class CampaignDashboardRecentActivitySection extends StatelessWidget {
  const CampaignDashboardRecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('campaign_dashboard_recent_activity-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Recent Activity Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}

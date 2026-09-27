import 'package:flutter/material.dart';

class PremiumConciergeDashboardRecentActivitySection extends StatelessWidget {
  final Map<String, dynamic> data;
  const PremiumConciergeDashboardRecentActivitySection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'premium_concierge_dashboard_recent_activity_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Recent Activity Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

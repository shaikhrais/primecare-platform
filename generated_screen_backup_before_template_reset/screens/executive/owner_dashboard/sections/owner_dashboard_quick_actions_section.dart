import 'package:flutter/material.dart';

class OwnerDashboardQuickActionsSection extends StatelessWidget {
  const OwnerDashboardQuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('owner_dashboard_quick_actions-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Quick Actions Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RnFieldSupervisorDashboardQuickActionsSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const RnFieldSupervisorDashboardQuickActionsSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'rn_field_supervisor_dashboard_quick_actions_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Quick Actions Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

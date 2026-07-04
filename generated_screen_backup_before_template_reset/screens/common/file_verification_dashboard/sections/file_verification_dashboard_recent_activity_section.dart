import 'package:flutter/material.dart';

class FileVerificationDashboardRecentActivitySection extends StatelessWidget {
  const FileVerificationDashboardRecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('file_verification_dashboard_recent_activity-section'),
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

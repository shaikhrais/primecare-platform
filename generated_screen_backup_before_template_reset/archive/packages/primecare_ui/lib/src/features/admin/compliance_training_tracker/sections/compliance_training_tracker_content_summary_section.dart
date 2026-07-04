import 'package:flutter/material.dart';

class ComplianceTrainingTrackerContentSummarySection extends StatelessWidget {
  const ComplianceTrainingTrackerContentSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('compliance_training_tracker_content_summary-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Content Summary Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}

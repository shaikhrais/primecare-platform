import 'package:flutter/material.dart';

class IntakeCoordinatorAssessmentQueueContentSummarySection extends StatelessWidget {
  const IntakeCoordinatorAssessmentQueueContentSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('intake_coordinator_assessment_queue_content_summary-section'),
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

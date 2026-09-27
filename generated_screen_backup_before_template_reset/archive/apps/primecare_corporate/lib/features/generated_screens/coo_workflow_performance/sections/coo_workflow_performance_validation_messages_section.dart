import 'package:flutter/material.dart';

class CooWorkflowPerformanceValidationMessagesSection extends StatelessWidget {
  const CooWorkflowPerformanceValidationMessagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('coo_workflow_performance_validation_messages-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Validation Messages Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}

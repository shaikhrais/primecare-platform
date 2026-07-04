import 'package:flutter/material.dart';

class RegionalBdmWorkflowTaskDetailsSection extends StatelessWidget {
  const RegionalBdmWorkflowTaskDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('regional_bdm_workflow_task_details-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Task Details Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}

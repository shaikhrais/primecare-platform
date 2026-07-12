import 'package:flutter/material.dart';

class GovernanceOfficerWorkflowTaskDetailsSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const GovernanceOfficerWorkflowTaskDetailsSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'governance_officer_workflow_task_details_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Task Details Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

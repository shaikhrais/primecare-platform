import 'package:flutter/material.dart';

class ScrumMasterWorkflowTaskListSection extends StatelessWidget {
  const ScrumMasterWorkflowTaskListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('scrum_master_workflow_task_list-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Task List Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}

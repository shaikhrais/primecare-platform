import 'package:flutter/material.dart';

class FamilyMemberWorkflowTaskListSection extends StatelessWidget {
  const FamilyMemberWorkflowTaskListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('family_member_workflow_task_list-section'),
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

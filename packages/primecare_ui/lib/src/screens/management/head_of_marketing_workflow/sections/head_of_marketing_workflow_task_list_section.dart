import 'package:flutter/material.dart';

class HeadOfMarketingWorkflowTaskListSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const HeadOfMarketingWorkflowTaskListSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'head_of_marketing_workflow_task_list_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Task List Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

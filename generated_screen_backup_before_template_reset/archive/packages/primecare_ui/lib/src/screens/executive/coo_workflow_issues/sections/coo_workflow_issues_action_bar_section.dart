import 'package:flutter/material.dart';

class CooWorkflowIssuesActionBarSection extends StatelessWidget {
  const CooWorkflowIssuesActionBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('coo_workflow_issues_action_bar-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Action Bar Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LpnWorkflowActionBarSection extends StatelessWidget {
  const LpnWorkflowActionBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('lpn_workflow_action_bar-section'),
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

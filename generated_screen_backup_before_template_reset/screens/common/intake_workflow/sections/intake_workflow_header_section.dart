import 'package:flutter/material.dart';

class IntakeWorkflowHeaderSection extends StatelessWidget {
  const IntakeWorkflowHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('intake_workflow_header-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Header Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TherapistWorkflowTaskFiltersSection extends StatelessWidget {
  const TherapistWorkflowTaskFiltersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('therapist_workflow_task_filters-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Task Filters Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}

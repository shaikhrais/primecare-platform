import 'package:flutter/material.dart';

class PhysiotherapistWorkflowTaskFiltersSection extends StatelessWidget {
  const PhysiotherapistWorkflowTaskFiltersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('physiotherapist_workflow_task_filters-section'),
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

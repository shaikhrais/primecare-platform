import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusText, PrimeStatusTone;
import 'package:flutter/material.dart';

class PhysiotherapistWorkflowTaskDetailsSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const PhysiotherapistWorkflowTaskDetailsSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'physiotherapist_workflow_task_details_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Task Details Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            PrimeStatusText('Clinical Care Operations Status.', tone: PrimeStatusTone.muted),
          ],
        ),
      ),
    );
  }
}

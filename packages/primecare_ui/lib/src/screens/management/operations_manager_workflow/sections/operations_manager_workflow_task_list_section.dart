import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusText, PrimeStatusTone;
import 'package:flutter/material.dart';

class OperationsManagerWorkflowTaskListSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const OperationsManagerWorkflowTaskListSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'operations_manager_workflow_task_list_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Task List Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            PrimeStatusText('Clinical Care Operations Status.', tone: PrimeStatusTone.muted),
          ],
        ),
      ),
    );
  }
}

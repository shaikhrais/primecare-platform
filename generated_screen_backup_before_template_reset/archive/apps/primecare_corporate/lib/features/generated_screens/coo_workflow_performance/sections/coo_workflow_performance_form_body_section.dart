import 'package:flutter/material.dart';

class CooWorkflowPerformanceFormBodySection extends StatelessWidget {
  const CooWorkflowPerformanceFormBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('coo_workflow_performance_form_body-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Form Body Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}

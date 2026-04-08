import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class ComplianceCorrectiveActionsScreen extends StatelessWidget {
  const ComplianceCorrectiveActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Corrective Actions (CAPA)',
      subtitle: 'Track active remediation plans following audit failures or critical safety incidents.',
      kpiCards: const [
        KPIConfig(label: 'Open CAPAs', value: '14', trend: '-2', color: Colors.orange),
        KPIConfig(label: 'Overdue Plans', value: '3', trend: 'Escalated', color: Colors.red),
        KPIConfig(label: 'Resolved YTD', value: '42', trend: 'Completed', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Remediation TimelineTracker', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Unified view of corrective task assignments, completion status, and re-audit schedules...'),
            ],
          ),
        ),
      ],
    );
  }
}

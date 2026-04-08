import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CooIssueEscalationsScreen extends StatelessWidget {
  const CooIssueEscalationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Issue Escalations',
      subtitle: 'Manage red-flag alerts sent up from clinic managers.',
      kpiCards: const [
        KPIConfig(label: 'Total Escalations', value: '28', trend: '-12', color: Colors.blue),
        KPIConfig(label: 'Critical Priority', value: '4', trend: 'P1', color: Colors.red),
        KPIConfig(label: 'Resolved 24h', value: '18', trend: 'Fast Track', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Executive Triage Board', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive kanban-style management of systemic operational blockers raised from regional directors...'),
            ],
          ),
        ),
      ],
    );
  }
}

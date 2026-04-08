import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class ComplianceIncidentReviewScreen extends StatelessWidget {
  const ComplianceIncidentReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Incident Review',
      subtitle: 'Triage, log, and assign investigators to safety occurrences.',
      kpiCards: const [
        KPIConfig(label: 'Reported Today', value: '4', trend: '+1 vs avg', color: Colors.orange),
        KPIConfig(label: 'Unassigned', value: '2', trend: 'Needs Triage', color: Colors.red),
        KPIConfig(label: 'Closed This Week', value: '18', trend: 'On Track', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Intake Queue', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Unified queue for reviewing newly submitted incident reports from all regional facilities...'),
            ],
          ),
        ),
      ],
    );
  }
}

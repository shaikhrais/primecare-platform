import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CooWorkflowPerformanceScreen extends StatelessWidget {
  const CooWorkflowPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Workflow Performance',
      subtitle:
          'Track metrics for individual clinical pathways (e.g. MSK diagnosis).',
      kpiCards: const [
        KPIConfig(
          label: 'Pathways Tracked',
          value: '14',
          trend: 'Active',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Fastest Route',
          value: 'Therapy',
          trend: '45m avg',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Slowest Route',
          value: 'Imaging',
          trend: 'Escalate',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Clinical Pathway Analytics',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Time-series analysis measuring the step-by-step efficiency of specialized clinical programs...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class BDMPipelineScreen extends StatelessWidget {
  const BDMPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Sales Pipeline (Regional)',
      subtitle: 'Visualize the full sales funnel with expected closing times.',
      kpiCards: const [
        KPIConfig(label: 'Funnel Size', value: '\$1.4M', trend: 'Q3', color: Colors.blue),
        KPIConfig(label: 'Closing 30d', value: '\$240k', trend: 'Committed', color: Colors.green),
        KPIConfig(label: 'Slipped Value', value: '\$14k', trend: 'Delayed', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Funnel Visualization', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Visual kanban board mapping deal progression from Qualification to Closed-Won...'),
            ],
          ),
        ),
      ],
    );
  }
}

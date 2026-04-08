import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class TerritoryActiveExpansionsScreen extends StatelessWidget {
  const TerritoryActiveExpansionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Active Expansions',
      subtitle: 'Track new facility construction and onboarding phases dynamically.',
      kpiCards: const [
        KPIConfig(label: 'Sites In Progress', value: '14', trend: 'Global', color: Colors.blue),
        KPIConfig(label: 'On Schedule', value: '12', trend: 'Pacing', color: Colors.green),
        KPIConfig(label: 'At Risk', value: '2', trend: 'Permits Delayed', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Build-Out Tracker', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Live chronological timeline view of physical clinic build-outs and their current stage...'),
            ],
          ),
        ),
      ],
    );
  }
}

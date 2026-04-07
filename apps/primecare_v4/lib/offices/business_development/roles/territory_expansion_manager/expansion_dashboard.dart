import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class ExpansionDashboardScreen extends StatelessWidget {
  const ExpansionDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Territory Expansion Dashboard',
      subtitle: 'Tracking upcoming territory acquisitions and market scouting.',
      kpiCards: const [
        KPIConfig(label: 'Target Territories', value: '12', trend: '+3', color: Colors.blue),
        KPIConfig(label: 'Active Scouting', value: '25', trend: 'Steady', color: Colors.orange),
        KPIConfig(label: 'Successful Expansions', value: '8', trend: '+2', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Territory Targets', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Pipeline of potential new territory acquisitions...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Scouting Reports', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Latest updates from field scouts...'),
            ],
          ),
        ),
      ],
    );
  }
}

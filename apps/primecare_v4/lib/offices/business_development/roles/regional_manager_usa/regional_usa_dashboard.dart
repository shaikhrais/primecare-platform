import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class RegionalUsaDashboardScreen extends StatelessWidget {
  const RegionalUsaDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Regional Manager USA Dashboard',
      subtitle: 'Performance snapshot and expansion planning for the US region.',
      kpiCards: const [
        KPIConfig(label: 'Total Partners', value: '124', trend: '+20%', color: Colors.blue),
        KPIConfig(label: 'State Expansion Progress', value: '8/50', trend: '+2', color: Colors.green),
        KPIConfig(label: 'US Revenue', value: '\$8.1M', trend: '+15%', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Performance by State', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Breakdown of metrics by state...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cross-Border Compliance Alerts', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Regulatory compliance notifications and reminders...'),
            ],
          ),
        ),
      ],
    );
  }
}

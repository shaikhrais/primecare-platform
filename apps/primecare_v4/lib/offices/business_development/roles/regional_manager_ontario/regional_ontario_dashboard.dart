import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class RegionalOntarioDashboardScreen extends StatelessWidget {
  const RegionalOntarioDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Regional Manager Ontario Dashboard',
      subtitle: 'Performance snapshot for the Ontario region.',
      kpiCards: const [
        KPIConfig(label: 'Total Clinics', value: '88', trend: '+4', color: Colors.blue),
        KPIConfig(label: 'Active Clients', value: '1,240', trend: '+12%', color: Colors.green),
        KPIConfig(label: 'Regional Revenue', value: '\$4.5M', trend: '+8%', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Performance by City', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Breakdown of metrics by Toronto, Ottawa, Mississauga, etc...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ontario Operations Alerts', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Specific issues affecting Ontario operations...'),
            ],
          ),
        ),
      ],
    );
  }
}

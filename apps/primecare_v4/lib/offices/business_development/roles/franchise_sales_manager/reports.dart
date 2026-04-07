import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class FranchiseReportsScreen extends StatelessWidget {
  const FranchiseReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Sales & Growth Analytics',
      subtitle: 'Analytics and projections for franchise sales.',
      kpiCards: const [
        KPIConfig(label: 'Quarterly Growth', value: '14%', trend: '+2%', color: Colors.green),
        KPIConfig(label: 'Lead Conversion', value: '8.2%', trend: '+0.5%', color: Colors.blue),
        KPIConfig(label: 'Projected Revenue', value: '\$12.5M', trend: '+18%', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Franchise Growth Over Time', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Line chart of acquired franchises and revenue tracking...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Conversion Funnel', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Funnel chart showing the drop-off from Lead to Closed Won...'),
            ],
          ),
        ),
      ],
    );
  }
}

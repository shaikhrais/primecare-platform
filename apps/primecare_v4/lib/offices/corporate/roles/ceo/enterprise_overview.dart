import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class EnterpriseOverviewScreen extends StatelessWidget {
  const EnterpriseOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Enterprise Overview',
      subtitle: 'High-level matrix demonstrating all clinics, corporate subsidiaries, and active joint ventures.',
      kpiCards: const [
        KPIConfig(label: 'Total Clinics', value: '142', trend: '+4', color: Colors.blue),
        KPIConfig(label: 'Subsidiaries', value: '12', trend: 'Stable', color: Colors.purple),
        KPIConfig(label: 'Joint Ventures', value: '3', trend: 'Active', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Global Footprint Map', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive geographic map of the entire operation network...'),
            ],
          ),
        ),
      ],
    );
  }
}

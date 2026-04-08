import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class OntarioRegionDashboardScreen extends StatelessWidget {
  const OntarioRegionDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Ontario Region Dashboard',
      subtitle:
          'High-level view of provincial growth, new client acquisition, and target pacing specific to Ontario.',
      kpiCards: const [
        KPIConfig(
          label: 'Q3 Pacing',
          value: '108%',
          trend: 'Ahead',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'New Clinics',
          value: '18',
          trend: 'This Month',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'At Risk',
          value: '3',
          trend: 'Churn Watch',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Provincial Performance',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Detailed analytics breaking down sales targets across the GTA, Ottawa, and surrounding areas...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

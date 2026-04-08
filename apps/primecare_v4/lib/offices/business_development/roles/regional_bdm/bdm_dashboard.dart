import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class RegionalBDMDashboardScreen extends StatelessWidget {
  const RegionalBDMDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Regional BDM Dashboard',
      subtitle: 'High-level view of regional growth, new client acquisition, and target pacing.',
      kpiCards: const [
        KPIConfig(label: 'Q3 Pacing', value: '112%', trend: 'Ahead', color: Colors.green),
        KPIConfig(label: 'New Clients', value: '24', trend: 'This Month', color: Colors.blue),
        KPIConfig(label: 'MRR Added', value: '\$84k', trend: 'Projected', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Regional Performance Matrix', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Detailed analytics breaking down sales targets by state and zip code...'),
            ],
          ),
        ),
      ],
    );
  }
}

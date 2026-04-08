import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class USARegionDashboardScreen extends StatelessWidget {
  const USARegionDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'USA Region Dashboard',
      subtitle: 'High-level view of national growth, new client acquisition, and target pacing specific to the USA.',
      kpiCards: const [
        KPIConfig(label: 'Q3 Pacing', value: '115%', trend: 'Ahead', color: Colors.green),
        KPIConfig(label: 'New Clinics', value: '48', trend: 'This Month', color: Colors.blue),
        KPIConfig(label: 'At Risk', value: '5', trend: 'Churn Watch', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('National Performance', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Detailed analytics breaking down sales targets across key anchor states (FL, NY, CA, TX)...'),
            ],
          ),
        ),
      ],
    );
  }
}

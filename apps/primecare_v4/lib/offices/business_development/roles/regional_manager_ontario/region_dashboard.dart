import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class OntarioRegionDashboardScreen extends StatelessWidget {
  const OntarioRegionDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Ontario Region Dashboard',
      subtitle: 'Key metrics, operations, and recent activity for the territory.',
      kpiCards: const [
        KPIConfig(label: 'Monthly Revenue', value: '\$1.2M', trend: '+5%', color: Colors.green),
        KPIConfig(label: 'Total Headcount', value: '340', trend: '+12', color: Colors.blue),
        KPIConfig(label: 'Incident Reports', value: '4', trend: 'Watch', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Activity Heatmap', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Visual chart showing daily operations across all Ontario clinics...'),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class UsaRegionDashboardScreen extends StatelessWidget {
  const UsaRegionDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'USA Region Dashboard',
      subtitle: 'Key metrics, operations, and recent activity for the United States.',
      kpiCards: const [
        KPIConfig(label: 'Monthly Revenue', value: '\$850k', trend: '+15%', color: Colors.green),
        KPIConfig(label: 'Total Headcount', value: '120', trend: '+20', color: Colors.blue),
        KPIConfig(label: 'Regulatory Filings', value: '3', trend: 'Pending', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('State-by-State Heatmap', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Visual chart showing daily operations across all US territories...'),
            ],
          ),
        ),
      ],
    );
  }
}

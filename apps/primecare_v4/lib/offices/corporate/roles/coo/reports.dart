import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CooReportsScreen extends StatelessWidget {
  const CooReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Executive Operations Reports',
      subtitle: 'Generate standard compliance and throughput packages for the board.',
      kpiCards: const [
        KPIConfig(label: 'Generated MTD', value: '84', trend: '+12', color: Colors.blue),
        KPIConfig(label: 'Scheduled', value: '14', trend: 'Automated', color: Colors.green),
        KPIConfig(label: 'Data Freshness', value: '4 mins', trend: 'Live Feed', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Report Builder', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Visual query builder allowing the COO to combine HR, compliance, and clinical metrics into single PDF briefings...'),
            ],
          ),
        ),
      ],
    );
  }
}

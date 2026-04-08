import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class FranchiseReportsScreen extends StatelessWidget {
  const FranchiseReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Sales Reports',
      subtitle: 'Generate board-ready analytics on franchise expansion ROI.',
      kpiCards: const [
        KPIConfig(label: 'Generated L30', value: '12', trend: 'Reports', color: Colors.blue),
        KPIConfig(label: 'Data Sync', value: 'Live', trend: 'Database', color: Colors.green),
        KPIConfig(label: 'Sharing', value: '24', trend: 'Exec Views', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Board Packages', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Automated collation of sales performance, marketing attribution, and signed territory values into presentation formats...'),
            ],
          ),
        ),
      ],
    );
  }
}

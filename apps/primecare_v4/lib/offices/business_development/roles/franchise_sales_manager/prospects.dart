import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class FranchiseProspectsScreen extends StatelessWidget {
  const FranchiseProspectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Prospects Directory',
      subtitle: 'Directory of highly qualified franchise prospects.',
      kpiCards: const [
        KPIConfig(label: 'Hot Prospects', value: '18', trend: '+5', color: Colors.red),
        KPIConfig(label: 'Avg Health Score', value: '8.5/10', trend: '+0.2', color: Colors.green),
        KPIConfig(label: 'Total Potential Value', value: '\$5.1M', trend: '+12%', color: Colors.blue),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Qualified Prospects', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Detailed directory with financial readiness and engagement metrics...'),
            ],
          ),
        ),
      ],
    );
  }
}

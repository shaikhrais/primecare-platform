import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CooBranchComparisonScreen extends StatelessWidget {
  const CooBranchComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Branch Comparison',
      subtitle:
          'Rank clinical locations out of 100 based on standard operational delivery scores.',
      kpiCards: const [
        KPIConfig(
          label: 'Avg Location Score',
          value: '82/100',
          trend: '+1.5',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Top Performer',
          value: 'Toronto',
          trend: '98/100',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Needs Attention',
          value: '4 Branches',
          trend: '< 65',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'League Table',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Interactive ranking of all physical assets by throughput, standard adherence, and patient sat...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

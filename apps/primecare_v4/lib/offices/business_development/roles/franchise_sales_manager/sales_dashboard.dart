import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class FranchiseSalesDashboardScreen extends StatelessWidget {
  const FranchiseSalesDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Sales Quota Dashboard',
      subtitle:
          'Track personal quota attainment and overarching revenue goals.',
      kpiCards: const [
        KPIConfig(
          label: 'Quota Attainment',
          value: '84%',
          trend: 'On Track',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'YTD Revenue',
          value: '\$4.2M',
          trend: 'Recognized',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Shortfall',
          value: '\$800k',
          trend: 'To Target',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Performance Heatmap',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Visual tracker showing quarter-over-quarter growth against the annual franchise expansion goals...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class FranchisePipelineDashboardScreen extends StatelessWidget {
  const FranchisePipelineDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Pipeline Dashboard',
      subtitle:
          'Track deal velocity and pipeline bottlenecks across the franchise sales cycle.',
      kpiCards: const [
        KPIConfig(
          label: 'Total Value',
          value: '\$14.2M',
          trend: 'Projected',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Avg Velocity',
          value: '42d',
          trend: 'Speed to Close',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Stalled Deals',
          value: '8',
          trend: '> 60 Days',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Funnel Analytics',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Macro-level conversion metrics showing drop-off rates between discovery calls and contract signatures...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

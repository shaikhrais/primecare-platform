import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class TerritoryExpansionMetricsScreen extends StatelessWidget {
  const TerritoryExpansionMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Unit Economics & Metrics',
      subtitle:
          'Track specific unit-economic KPIs matching new capital investments.',
      kpiCards: const [
        KPIConfig(
          label: 'Avg Build Cost',
          value: '\$1.1M',
          trend: 'Targeted',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Payback Period',
          value: '18m',
          trend: 'Modeled',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'CapEx Yield',
          value: '22%',
          trend: 'Est',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Capital Expenditure (CapEx)',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Calculations measuring the capital efficiency and return per clinic location rollout...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

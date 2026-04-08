import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CeoRegionPerformanceScreen extends StatelessWidget {
  const CeoRegionPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Region Performance',
      subtitle:
          'Comparison between USA, Canada, and specific state/province subsidiaries.',
      kpiCards: const [
        KPIConfig(
          label: 'Top Region',
          value: 'Ontario',
          trend: '\$14M ARR',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Fastest Growth',
          value: 'Texas',
          trend: '+22%',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Underperforming',
          value: '0',
          trend: 'None',
          color: Colors.purple,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Comparative Matrix',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Grid charting gross margins, patient volume, and compliance scores side-by-side...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

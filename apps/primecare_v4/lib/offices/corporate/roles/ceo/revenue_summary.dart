import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CeoRevenueSummaryScreen extends StatelessWidget {
  const CeoRevenueSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Revenue Summary',
      subtitle: 'Breakdown of top-line growth across B2B partnerships vs B2C clinical encounters.',
      kpiCards: const [
        KPIConfig(label: 'Total Revenue YTD', value: '\$142M', trend: '+15%', color: Colors.blue),
        KPIConfig(label: 'B2B Share', value: '42%', trend: '+2%', color: Colors.purple),
        KPIConfig(label: 'Avg Encounter Value', value: '\$205', trend: '+\$14', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Revenue Pipeline', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Stacked bar graph analyzing revenue origin and predictive growth for the coming quarters...'),
            ],
          ),
        ),
      ],
    );
  }
}

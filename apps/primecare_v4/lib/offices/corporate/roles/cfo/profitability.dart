import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CfoProfitabilityScreen extends StatelessWidget {
  const CfoProfitabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Profitability Deep-Dive',
      subtitle: 'Gross-margins across different types of clinic offerings (Therapy vs Outpatient).',
      kpiCards: const [
        KPIConfig(label: 'Net Margin', value: '22%', trend: '+1.5%', color: Colors.green),
        KPIConfig(label: 'Highest Margin', value: 'Therapy', trend: '34%', color: Colors.blue),
        KPIConfig(label: 'Loss Leaders', value: '2', trend: 'Watch', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Service Line Profitability', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Comparative scatter-plot of margin vs volume for all major clinical services...'),
            ],
          ),
        ),
      ],
    );
  }
}

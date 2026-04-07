import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class ExpansionReportsScreen extends StatelessWidget {
  const ExpansionReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Expansion Reports',
      subtitle: 'Summarizing the status of 12-month expansion plans and risk assessments.',
      kpiCards: const [
        KPIConfig(label: 'Reports Generated', value: '12', trend: 'Monthly', color: Colors.blue),
        KPIConfig(label: 'High Risk Projects', value: '1', trend: '-1', color: Colors.orange),
        KPIConfig(label: 'On Schedule', value: '92%', trend: '+4%', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Quarterly Overviews', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Detailed breakdown of expansion success rates, bottlenecks, and financial outlays...'),
            ],
          ),
        ),
      ],
    );
  }
}

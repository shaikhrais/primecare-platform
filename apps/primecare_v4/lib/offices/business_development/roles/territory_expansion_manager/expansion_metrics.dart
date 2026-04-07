import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class ExpansionMetricsScreen extends StatelessWidget {
  const ExpansionMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Expansion Metrics',
      subtitle: 'Cost per new territory, ROI of newly opened branches, and market penetration stats.',
      kpiCards: const [
        KPIConfig(label: 'Avg Cost/Clinic', value: '\$850k', trend: '-2%', color: Colors.green),
        KPIConfig(label: 'Y1 ROI', value: '18%', trend: '+3%', color: Colors.blue),
        KPIConfig(label: 'Market Penetration', value: '2.4%', trend: '+0.4%', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Financial Performance', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Charts outlining capital expenditure versus actual returns per region...'),
            ],
          ),
        ),
      ],
    );
  }
}

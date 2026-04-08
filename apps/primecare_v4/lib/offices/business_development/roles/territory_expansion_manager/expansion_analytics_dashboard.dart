import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class TerritoryExpansionAnalyticsScreen extends StatelessWidget {
  const TerritoryExpansionAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Expansion Analytics & Forecasting',
      subtitle: 'View comprehensive quantitative models on future healthcare demand by region.',
      kpiCards: const [
        KPIConfig(label: 'Demand Surge', value: '+14%', trend: 'National', color: Colors.blue),
        KPIConfig(label: 'Est Capital', value: '\$24M', trend: 'Required', color: Colors.orange),
        KPIConfig(label: 'Projected ROI', value: '18%', trend: '12 Month', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Macro Expansion Modeling', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Algorithmically generated forecasts determining internal resource requirement scaling for next FY...'),
            ],
          ),
        ),
      ],
    );
  }
}

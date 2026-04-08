import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class TerritoryMarketResearchScreen extends StatelessWidget {
  const TerritoryMarketResearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Market Research Hub',
      subtitle: 'Store focus group results and healthcare polling data.',
      kpiCards: const [
        KPIConfig(label: 'Focus Groups', value: '14', trend: 'Completed', color: Colors.blue),
        KPIConfig(label: 'Avg Sentiment', value: '72%', trend: 'Favorable', color: Colors.green),
        KPIConfig(label: 'Polls Active', value: '4', trend: 'In Field', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Consumer Healthcare Polling', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Qualitative repository storing consumer sentiment towards existing local healthcare providers...'),
            ],
          ),
        ),
      ],
    );
  }
}

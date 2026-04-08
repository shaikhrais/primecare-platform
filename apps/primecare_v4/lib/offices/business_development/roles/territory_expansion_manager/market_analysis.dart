import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class TerritoryMarketAnalysisScreen extends StatelessWidget {
  const TerritoryMarketAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Competitive Market Analysis',
      subtitle:
          'Swot analysis and competitive intelligence portal for proposed cities.',
      kpiCards: const [
        KPIConfig(
          label: 'Markets Eval',
          value: '8',
          trend: 'Active',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Saturation',
          value: '41%',
          trend: 'National',
          color: Colors.orange,
        ),
        KPIConfig(
          label: 'Opportunities',
          value: '14',
          trend: 'Prime',
          color: Colors.green,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SWOT Analytics',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Competitive tracking, assessing the regional strength of other corporate health groups...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class RegionalBdmTerritoryGrowthScreen extends StatelessWidget {
  const RegionalBdmTerritoryGrowthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Territory Growth Analytics',
      subtitle: 'Market penetration map, whitespace analysis, and expansion targeting.',
      kpiCards: const [
        KPIConfig(label: 'Penetration Rate', value: '18%', trend: '+2%', color: Colors.green),
        KPIConfig(label: 'Target Whitespace', value: '14 Zones', trend: 'Actionable', color: Colors.purple),
        KPIConfig(label: 'Growth YoY', value: '34%', trend: 'High', color: Colors.blue),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Territory Heatmap', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Map view highlighting high-capture vs unpenetrated zip codes...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Expansion Targets', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Prioritized list of target areas based on demographic scores...'),
            ],
          ),
        ),
      ],
    );
  }
}

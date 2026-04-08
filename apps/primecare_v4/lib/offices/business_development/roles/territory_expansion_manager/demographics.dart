import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class TerritoryDemographicsScreen extends StatelessWidget {
  const TerritoryDemographicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Demographic Heatmaps',
      subtitle: 'Analyze population heatmaps and competing healthcare facilities in target zip codes.',
      kpiCards: const [
        KPIConfig(label: 'Target Regions', value: '38', trend: 'Analyzed', color: Colors.blue),
        KPIConfig(label: 'Avg Density', value: '412/sqmi', trend: 'Optimal', color: Colors.green),
        KPIConfig(label: 'Competitor Density', value: 'High', trend: 'Monitor', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Geospatial Saturation Map', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive demographic model assessing ROI of new clinic locations against localized census data...'),
            ],
          ),
        ),
      ],
    );
  }
}

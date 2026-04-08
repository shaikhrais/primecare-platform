import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class OntarioTerritoryTrackingScreen extends StatelessWidget {
  const OntarioTerritoryTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Ontario Territory Mapping',
      subtitle: 'Geographic mapping of covered accounts and white-space analysis across Ontario districts.',
      kpiCards: const [
        KPIConfig(label: 'Postal Codes', value: '840', trend: 'Covered', color: Colors.blue),
        KPIConfig(label: 'Penetration', value: '45%', trend: 'Expanding', color: Colors.green),
        KPIConfig(label: 'Open Areas', value: '12', trend: 'High Priority', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Geospatial Analytics', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Map overlay displaying density of current GTA clients against addressable municipal capacity...'),
            ],
          ),
        ),
      ],
    );
  }
}

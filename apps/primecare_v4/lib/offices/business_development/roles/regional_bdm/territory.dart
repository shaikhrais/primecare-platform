import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class BDMTerritoryScreen extends StatelessWidget {
  const BDMTerritoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Territory Mapping',
      subtitle: 'Geographic mapping of covered accounts and white-space analysis.',
      kpiCards: const [
        KPIConfig(label: 'Total Zip Codes', value: '142', trend: 'Covered', color: Colors.blue),
        KPIConfig(label: 'Penetration', value: '38%', trend: 'Expanding', color: Colors.green),
        KPIConfig(label: 'Target Areas', value: '4', trend: 'High Priority', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Geospatial Analytics', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Map overlay displaying density of current clients against addressable market capacity...'),
            ],
          ),
        ),
      ],
    );
  }
}

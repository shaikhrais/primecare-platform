import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class USATerritoryTrackingScreen extends StatelessWidget {
  const USATerritoryTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'USA Territory Mapping',
      subtitle: 'Geographic mapping of covered accounts and white-space analysis across American districts.',
      kpiCards: const [
        KPIConfig(label: 'Total Zip Codes', value: '1,420', trend: 'Covered', color: Colors.blue),
        KPIConfig(label: 'Penetration', value: '15%', trend: 'Expanding', color: Colors.green),
        KPIConfig(label: 'Open Areas', value: '42', trend: 'High Priority', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Geospatial Analytics', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Map overlay displaying density of current sun-belt clients against addressable metropolitan capacity...'),
            ],
          ),
        ),
      ],
    );
  }
}

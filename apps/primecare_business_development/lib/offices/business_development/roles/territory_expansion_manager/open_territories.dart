import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class TerritoryOpenTerritoriesScreen extends StatelessWidget {
  const TerritoryOpenTerritoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Open White-Space Territories',
      subtitle: 'Log all geographies without existing healthcare coverage.',
      kpiCards: const [
        KPIConfig(
          label: 'Identified',
          value: '42',
          trend: 'Zip Codes',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Pop Density',
          value: '1.4M',
          trend: 'Addressable',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'No Coverage',
          value: '14',
          trend: 'Counties',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Uncharted Market Analysis',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Interactive registry mapping highly populated rural and suburban regions currently devoid of modern clinical facilities...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

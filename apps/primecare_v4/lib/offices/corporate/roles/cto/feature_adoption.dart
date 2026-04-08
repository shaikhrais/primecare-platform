import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CtoFeatureAdoptionScreen extends StatelessWidget {
  const CtoFeatureAdoptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Feature Adoption',
      subtitle: 'Monitor rollouts of new clinical software tools.',
      kpiCards: const [
        KPIConfig(
          label: 'Total Active Users',
          value: '18.4k',
          trend: '+4%',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Telehealth Adoption',
          value: '42%',
          trend: '+8%',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Unused Module Cost',
          value: '\$14k',
          trend: '-2k',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Module Utilization Matrix',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Visual categorization of the PrimeCare ecosystem based on DAU (Daily Active Users) and total interactions...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

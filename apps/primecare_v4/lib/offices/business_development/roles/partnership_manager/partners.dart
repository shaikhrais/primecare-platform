import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class PartnersMatrixScreen extends StatelessWidget {
  const PartnersMatrixScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Partner Strategy Matrix',
      subtitle: 'Matrix mapping strategic partners to their core value propositions.',
      kpiCards: const [
        KPIConfig(label: 'Strategic Tech Partners', value: '8', trend: 'Stable', color: Colors.blue),
        KPIConfig(label: 'Referral Partners', value: '18', trend: '+2', color: Colors.green),
        KPIConfig(label: 'Service Providers', value: '30', trend: 'Watch', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Partnership Grid', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Grid layout grouping partners by category (Tech, Referral, Service, Supply Chain)...'),
            ],
          ),
        ),
      ],
    );
  }
}

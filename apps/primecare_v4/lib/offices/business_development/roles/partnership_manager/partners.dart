import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class PartnershipPartnersScreen extends StatelessWidget {
  const PartnershipPartnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Partner Directory',
      subtitle: 'View detailed performance scorecards for each hospital partner.',
      kpiCards: const [
        KPIConfig(label: 'Total Partners', value: '412', trend: 'Global Database', color: Colors.blue),
        KPIConfig(label: 'Avg Health', value: '88/100', trend: 'Strong', color: Colors.green),
        KPIConfig(label: 'Inactive', value: '14', trend: 'L90 Days', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Partner Scorecards', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive grid linking directly to individual partner health pages...'),
            ],
          ),
        ),
      ],
    );
  }
}

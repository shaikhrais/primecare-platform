import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class PartnershipActiveDealsScreen extends StatelessWidget {
  const PartnershipActiveDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Active Deal Negotiations',
      subtitle:
          'Track B2B partnership negotiations and hospital syndications currently in progress.',
      kpiCards: const [
        KPIConfig(
          label: 'Live Negotiations',
          value: '24',
          trend: 'Active',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Deal Value',
          value: '\$8.4M',
          trend: 'Projected',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Stalled Deals',
          value: '4',
          trend: 'Legal Review',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Deal Desk', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text(
                'Interactive deal tracker highlighting current stage, legal review status, and expected close dates...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

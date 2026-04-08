import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class GeneralManagerOpsDashboardScreen extends StatelessWidget {
  const GeneralManagerOpsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'BizDev Operations Dashboard',
      subtitle:
          'Track overarching growth goals, operational bottlenecks, and territory mapping.',
      kpiCards: const [
        KPIConfig(
          label: 'Global MRR Add',
          value: '\$1.2M',
          trend: 'L30 Days',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Avg Launch Time',
          value: '142 Days',
          trend: '-14 Days',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Bottlenecks',
          value: '3',
          trend: 'Requires Attention',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Growth Operations Overview',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Macro-level visibility into all global expansion regions, highlighting onboarding blockers...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

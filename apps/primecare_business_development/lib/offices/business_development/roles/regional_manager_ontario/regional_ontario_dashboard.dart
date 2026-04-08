import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class RegionalOntarioDashboardScreen extends StatelessWidget {
  const RegionalOntarioDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Ontario Operations Metrics',
      subtitle:
          'Provides deep-dive operational metrics and compliance tracking specific to Ontario health regulations (OHIP).',
      kpiCards: const [
        KPIConfig(
          label: 'OHIP Disputes',
          value: '42',
          trend: 'Resolved',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'MOH Audits',
          value: '1',
          trend: 'Pending',
          color: Colors.orange,
        ),
        KPIConfig(
          label: 'Compliance',
          value: '99%',
          trend: 'Score',
          color: Colors.green,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Regulatory Compliance',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Tracker for provincial billing number registrations and OHIP submission timelines...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class ComplianceReportsScreen extends StatelessWidget {
  const ComplianceReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Compliance Reports',
      subtitle:
          'Generate and export targeted PDFs for external regulatory boards.',
      kpiCards: const [
        KPIConfig(
          label: 'Total Generated',
          value: '42',
          trend: 'This Month',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Scheduled Dispatches',
          value: '8',
          trend: 'Automated',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Failed Syncs',
          value: '0',
          trend: 'System Healthy',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Regulatory Templates',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Generator library for standardizing mandatory reporting formats sent to regional health authorities...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

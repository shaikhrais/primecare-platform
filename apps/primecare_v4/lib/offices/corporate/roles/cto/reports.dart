import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CtoReportsScreen extends StatelessWidget {
  const CtoReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Engineering Reports',
      subtitle: 'Generate and export targeted PDFs for board-level technical reviews.',
      kpiCards: const [
        KPIConfig(label: 'Reports Generated', value: '14', trend: 'This Month', color: Colors.blue),
        KPIConfig(label: 'System Audits', value: '4', trend: 'Completed', color: Colors.green),
        KPIConfig(label: 'SLA Exceptions', value: '2', trend: 'Review Required', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Board Pack Generator', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Automated collation of uptime, budget, and security metrics into standardized executive presentations...'),
            ],
          ),
        ),
      ],
    );
  }
}

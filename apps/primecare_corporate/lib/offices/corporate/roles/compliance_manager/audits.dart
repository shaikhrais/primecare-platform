import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class ComplianceAuditsScreen extends StatelessWidget {
  const ComplianceAuditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Enterprise Audits',
      subtitle:
          'Tracking of internal gap analyses and external regulatory inspections.',
      kpiCards: const [
        KPIConfig(
          label: 'Active Audits',
          value: '4',
          trend: 'In Progress',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Pending Reviews',
          value: '12',
          trend: 'Needs Action',
          color: Colors.orange,
        ),
        KPIConfig(
          label: 'Passed',
          value: '38',
          trend: 'This Year',
          color: Colors.green,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Audit Pipeline',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Detailed chronological view of all upcoming and past safety and compliance audits...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

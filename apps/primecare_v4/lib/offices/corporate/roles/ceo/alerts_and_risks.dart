import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CeoAlertsAndRisksScreen extends StatelessWidget {
  const CeoAlertsAndRisksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Alerts & Risks',
      subtitle: 'Enterprise-wide compliance, financial, and operational risk summaries.',
      kpiCards: const [
        KPIConfig(label: 'Critical Risks', value: '2', trend: 'Needs Review', color: Colors.red),
        KPIConfig(label: 'Compliance Flags', value: '14', trend: 'Active', color: Colors.orange),
        KPIConfig(label: 'System Health', value: '99.9%', trend: 'Operational', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Executive Threat Board', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Unified view of regulatory, cybersecurity, and financial risks escalated to the C-suite...'),
            ],
          ),
        ),
      ],
    );
  }
}

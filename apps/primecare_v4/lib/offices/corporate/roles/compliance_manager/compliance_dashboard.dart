import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class ComplianceDashboardScreen extends StatelessWidget {
  const ComplianceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Compliance Dashboard',
      subtitle: 'High-level reporting on incident counts, audit findings, and credential expiry risks.',
      kpiCards: const [
        KPIConfig(label: 'Vitality Score', value: '98%', trend: '+1%', color: Colors.green),
        KPIConfig(label: 'Active Incidents', value: '12', trend: '2 Critical', color: Colors.orange),
        KPIConfig(label: 'Expiring Credentials', value: '14', trend: 'Next 30 Days', color: Colors.red),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Audit Readiness', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Overall progress bars mapping tracking status for ongoing remediation actions...'),
            ],
          ),
        ),
      ],
    );
  }
}

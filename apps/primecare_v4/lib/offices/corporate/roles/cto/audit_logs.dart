import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CtoAuditLogsScreen extends StatelessWidget {
  const CtoAuditLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'System Audit Logs',
      subtitle: 'View HIPAA-compliant immutable logs of all clinical record access.',
      kpiCards: const [
        KPIConfig(label: 'Log Storage', value: '14.2 TB', trend: 'Encrypted', color: Colors.blue),
        KPIConfig(label: 'Anomalies', value: '0', trend: 'Past 24h', color: Colors.green),
        KPIConfig(label: 'Access Flags', value: '2', trend: 'Review Required', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Immutable Ledger Feed', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Live searching and filtering of security events, administrative actions, and patient data lookups...'),
            ],
          ),
        ),
      ],
    );
  }
}

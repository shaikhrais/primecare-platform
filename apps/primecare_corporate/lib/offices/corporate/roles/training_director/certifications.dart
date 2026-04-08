import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class TrainingCertificationsScreen extends StatelessWidget {
  const TrainingCertificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Certifications Management',
      subtitle:
          'Track automated delivery of pass certificates to staff HR profiles.',
      kpiCards: const [
        KPIConfig(
          label: 'Issued L30D',
          value: '1,420',
          trend: 'Sent',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Sync Rate',
          value: '99.9%',
          trend: 'HRIS Connect',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Sync Errors',
          value: '3',
          trend: 'Resolve',
          color: Colors.red,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Issuance Log',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Live feed of digital certificates generated and pushed to enterprise HR records...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

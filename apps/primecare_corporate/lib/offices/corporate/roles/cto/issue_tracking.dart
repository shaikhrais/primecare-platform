import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CtoIssueTrackingScreen extends StatelessWidget {
  const CtoIssueTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Issue Tracking',
      subtitle:
          'Monitor software bugs mapped to the clinical components they affect.',
      kpiCards: const [
        KPIConfig(
          label: 'Open Defects',
          value: '142',
          trend: '-18',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'P1 Severity',
          value: '2',
          trend: 'Urgent',
          color: Colors.red,
        ),
        KPIConfig(
          label: 'MTTR',
          value: '4h 12m',
          trend: '-20m',
          color: Colors.green,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Clinical Impact Matrix',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Categorized view plotting logged technical defects against critical clinical pathways...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

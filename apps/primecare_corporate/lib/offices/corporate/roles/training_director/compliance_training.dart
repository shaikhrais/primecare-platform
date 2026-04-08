import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class ComplianceTrainingScreen extends StatelessWidget {
  const ComplianceTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Compliance Mapping',
      subtitle:
          'Map course completions against mandatory state/provincial healthcare regulations.',
      kpiCards: const [
        KPIConfig(
          label: 'Regulatory Auth',
          value: 'HHS/CMS',
          trend: 'Federal',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Mapped Staff',
          value: '100%',
          trend: 'Compliant',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Upcoming Recerts',
          value: '412',
          trend: '< 30d',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'State Mandate Matrix',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Visual linking of localized legal requirements to our internal SCORM curriculum...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

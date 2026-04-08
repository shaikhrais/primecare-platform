import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class ComplianceTrainingComplianceScreen extends StatelessWidget {
  const ComplianceTrainingComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Training Compliance',
      subtitle:
          'Track mandatory safety and protocol training completion rates for clinical staff.',
      kpiCards: const [
        KPIConfig(
          label: 'Completion Rate',
          value: '88%',
          trend: '+2%',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Past Due',
          value: '312',
          trend: 'Staff Members',
          color: Colors.orange,
        ),
        KPIConfig(
          label: 'New Courses',
          value: '2',
          trend: 'HIPAA & OSHA',
          color: Colors.blue,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Module Tracking',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Granular completion statuses categorized by clinical department and geographical region...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

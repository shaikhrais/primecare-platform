import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class TrainingAssessmentsScreen extends StatelessWidget {
  const TrainingAssessmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Global Assessments',
      subtitle: 'Track ongoing examination scoring for clinical staff cohorts.',
      kpiCards: const [
        KPIConfig(
          label: 'Total Assessments',
          value: '4,102',
          trend: 'L30 Days',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Avg Score',
          value: '88.4%',
          trend: '+2.1%',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Fail Rate',
          value: '3.1%',
          trend: 'Monitor',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Examination Cohorts',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Detailed breakdown of recent test scores across departments, highlighting areas needing curriculum revision...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

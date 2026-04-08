import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class TrainingDirectorDashboardScreen extends StatelessWidget {
  const TrainingDirectorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Training Directorate',
      subtitle:
          'Track global educational compliance for clinical staff, overall pass rates, and active course rollouts.',
      kpiCards: const [
        KPIConfig(
          label: 'Global Passing Rate',
          value: '94%',
          trend: 'Target Met',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Active Course Rollouts',
          value: '4',
          trend: 'Live',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'At-Risk Certs',
          value: '112',
          trend: '< 14h Left',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enterprise Training Compliance',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'A macro-level heat map showing training completion and exam scoring averages mapped by facility region...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

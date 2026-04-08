import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class TrainerAssignmentsScreen extends StatelessWidget {
  const TrainerAssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Trainer Assignments',
      subtitle: 'Map senior educators to specific facility training rollouts.',
      kpiCards: const [
        KPIConfig(
          label: 'Active Trainers',
          value: '142',
          trend: 'Deployed',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Utilization',
          value: '84%',
          trend: 'Optimal',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Benched',
          value: '12',
          trend: 'Available',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deployment Schedule',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Gantt-style calendar visualizing which educators are currently embedded at which physical facilities...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

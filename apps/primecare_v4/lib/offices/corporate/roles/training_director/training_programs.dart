import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class TrainingProgramsScreen extends StatelessWidget {
  const TrainingProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Training Programs',
      subtitle: 'Structure multi-week onboarding pipelines and specialty tracks.',
      kpiCards: const [
        KPIConfig(label: 'Active Pipelines', value: '8', trend: 'Live', color: Colors.blue),
        KPIConfig(label: 'Enrolled Staff', value: '1,420', trend: 'Learning', color: Colors.green),
        KPIConfig(label: 'Dropout Rate', value: '2.4%', trend: 'Monitor', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Curriculum Builder', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Drag-and-drop interface for linking discrete courses into formal, multi-stage certification programs...'),
            ],
          ),
        ),
      ],
    );
  }
}

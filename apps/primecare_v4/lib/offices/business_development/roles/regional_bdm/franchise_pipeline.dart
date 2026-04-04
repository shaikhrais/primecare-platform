import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class RegionalBdmPipelineScreen extends StatelessWidget {
  const RegionalBdmPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Regional Franchise Pipeline',
      subtitle: 'Kanban tracking for potential franchise partners in this territory.',
      kpiCards: const [
        KPIConfig(label: 'Active Opportunities', value: '22', trend: '+4', color: Colors.blue),
        KPIConfig(label: 'Discovery Phase', value: '8', trend: 'Steady', color: Colors.purple),
        KPIConfig(label: 'Closing', value: '3', trend: 'Hot', color: Colors.red),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pipeline Kanban Board', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Visual board moving deals from Initial Contact -> Legal -> Signed...'),
            ],
          ),
        ),
      ],
    );
  }
}

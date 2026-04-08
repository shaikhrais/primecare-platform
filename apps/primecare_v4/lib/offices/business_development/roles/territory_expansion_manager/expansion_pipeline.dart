import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class TerritoryExpansionPipelineScreen extends StatelessWidget {
  const TerritoryExpansionPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Rollout Pipeline',
      subtitle: 'Visual funnel showing the journey from initial market identification to ribbon cutting.',
      kpiCards: const [
        KPIConfig(label: 'Market ID', value: '84', trend: 'Phase 1', color: Colors.blue),
        KPIConfig(label: 'Architectural', value: '12', trend: 'Phase 3', color: Colors.orange),
        KPIConfig(label: 'Go-Live', value: '4', trend: 'Ribbon Cut', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pipeline Funnel', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive kanban tracking physical sites from initial zoning inquiry to final health inspection...'),
            ],
          ),
        ),
      ],
    );
  }
}

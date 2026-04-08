import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class FranchisePipelineView extends StatelessWidget {
  const FranchisePipelineView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Strategic Franchise Expansion',
      subtitle: 'Kanban view: Track leads from prospect to signed contract execution.',
      kpiCards: const [
        KPIConfig(label: 'Total Pipeline', value: '\$12.4M', trend: 'Projected', color: Colors.blue),
        KPIConfig(label: 'Deal Velocity', value: '48 Days', trend: 'Avg Close', color: Colors.green),
        KPIConfig(label: 'Stalled Deals', value: '14', trend: '> 60 Days', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Franchise Opportunity Board', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Drag-and-drop pipeline visualizing all ongoing negotiations across all territory stages...'),
            ],
          ),
        ),
      ],
    );
  }
}

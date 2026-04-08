import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class TerritoryExpansionManagementScreen extends StatelessWidget {
  const TerritoryExpansionManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Rollout Logistics',
      subtitle: 'A kanban board managing the logistical rollout of new physical locations.',
      kpiCards: const [
        KPIConfig(label: 'Pending Sites', value: '42', trend: 'Pipeline', color: Colors.blue),
        KPIConfig(label: 'Legal Review', value: '8', trend: 'Blocked', color: Colors.orange),
        KPIConfig(label: 'Ready Build', value: '12', trend: 'Cleared', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Logistics Board', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Kanban tracking architectural drawings, city permit approvals, and contractor bidding...'),
            ],
          ),
        ),
      ],
    );
  }
}

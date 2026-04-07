import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class ExpansionPipelineScreen extends StatelessWidget {
  const ExpansionPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Expansion Pipeline',
      subtitle: 'Funnel of potential new territories from scouting to lease signing.',
      kpiCards: const [
        KPIConfig(label: 'Locations Scouted', value: '82', trend: '+12', color: Colors.blue),
        KPIConfig(label: 'LOIs Signed', value: '15', trend: '+4', color: Colors.green),
        KPIConfig(label: 'Dropped Deals', value: '6', trend: 'Stable', color: Colors.red),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Deal Flow Board', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Kanban view of properties moving from initial identification to successful launch...'),
            ],
          ),
        ),
      ],
    );
  }
}

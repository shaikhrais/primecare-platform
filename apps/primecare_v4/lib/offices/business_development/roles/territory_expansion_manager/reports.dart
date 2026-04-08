import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class TerritoryReportsScreen extends StatelessWidget {
  const TerritoryReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Expansion Reports',
      subtitle: 'Generate PDF boardroom expansion reports for stakeholders.',
      kpiCards: const [
        KPIConfig(label: 'Generated', value: '14', trend: 'This Quarter', color: Colors.blue),
        KPIConfig(label: 'Avg Read', value: '82%', trend: 'Engagement', color: Colors.green),
        KPIConfig(label: 'Pending', value: '2', trend: 'Review', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Stakeholder Presentations', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Repository of compiled market feasibility decks securely formatted for C-suite distribution...'),
            ],
          ),
        ),
      ],
    );
  }
}

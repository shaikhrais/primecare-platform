import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class RegionalBdmLeadsScreen extends StatelessWidget {
  const RegionalBdmLeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Inbound & Outbound Leads',
      subtitle: 'Track leads, health scoring, and regional distribution.',
      kpiCards: const [
        KPIConfig(label: 'Total Leads (YTD)', value: '840', trend: '+15%', color: Colors.blue),
        KPIConfig(label: 'High Quality', value: '25%', trend: '+2%', color: Colors.green),
        KPIConfig(label: 'Contact Rate', value: '64%', trend: 'Improving', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lead Distribution Map', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Geographical heatmap of where leads are originating in the territory...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lead Scoring Matrix', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Detailed list prioritizing leads based on engagement and fit score...'),
            ],
          ),
        ),
      ],
    );
  }
}

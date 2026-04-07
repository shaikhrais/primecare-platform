import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class RegionalBdmPartnersScreen extends StatelessWidget {
  const RegionalBdmPartnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Territory Partners',
      subtitle: 'Active partnerships, revenue generation, and tier scoring in this region.',
      kpiCards: const [
        KPIConfig(label: 'Total Partners', value: '34', trend: '+2', color: Colors.blue),
        KPIConfig(label: 'Partner Revenue', value: '\$450k', trend: '+15%', color: Colors.green),
        KPIConfig(label: 'Avg Health Score', value: '88/100', trend: 'Solid', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Partner Directory', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Detailed list showing Partner Name, Tier, YTD Revenue, and Status...'),
            ],
          ),
        ),
      ],
    );
  }
}

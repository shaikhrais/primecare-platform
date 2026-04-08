import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class TerritoryMapScreen extends StatelessWidget {
  const TerritoryMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Global Territory Map',
      subtitle: 'High-level dashboard plotting the location of all currently operating facilities nationwide.',
      kpiCards: const [
        KPIConfig(label: 'Active Facilities', value: '412', trend: 'Live', color: Colors.blue),
        KPIConfig(label: 'Growth Rate', value: '+14%', trend: 'YoY', color: Colors.green),
        KPIConfig(label: 'Max Density', value: 'Florida', trend: 'State', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('National Footprint', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Macro view rendering all owned, operated, and partnered clinical locations across North America...'),
            ],
          ),
        ),
      ],
    );
  }
}

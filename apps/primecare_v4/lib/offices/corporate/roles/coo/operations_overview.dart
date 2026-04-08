import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CooOperationsOverviewScreen extends StatelessWidget {
  const CooOperationsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Operations Overview',
      subtitle: 'Track high-level metrics across all global clinical operations.',
      kpiCards: const [
        KPIConfig(label: 'Total Real Estate', value: '4.2M sqft', trend: 'Global', color: Colors.blue),
        KPIConfig(label: 'Supply Chain Index', value: '98/100', trend: 'Optimal', color: Colors.green),
        KPIConfig(label: 'Downtime', value: '0.4%', trend: 'Minimal', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Global Enterprise Health', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('A geographical heat map reflecting the operational capacity and friction points of every PrimeCare location...'),
            ],
          ),
        ),
      ],
    );
  }
}

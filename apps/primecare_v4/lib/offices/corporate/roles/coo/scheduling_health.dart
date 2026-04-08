import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CooSchedulingHealthScreen extends StatelessWidget {
  const CooSchedulingHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Scheduling Health',
      subtitle: 'Map out network-wide staff-to-patient ratios.',
      kpiCards: const [
        KPIConfig(label: 'Global Fill Rate', value: '88%', trend: '+4%', color: Colors.green),
        KPIConfig(label: 'Unfilled Shifts', value: '42', trend: '< 24H', color: Colors.orange),
        KPIConfig(label: 'No-Show Rate', value: '4.2%', trend: '-0.5%', color: Colors.blue),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Network Scheduling Optimization', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Comparative load balancing analysis across all regions to identify under/over-staffed territories...'),
            ],
          ),
        ),
      ],
    );
  }
}

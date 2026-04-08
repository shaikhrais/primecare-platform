import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CooOpsEfficiencyScreen extends StatelessWidget {
  const CooOpsEfficiencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Efficiency Analytics',
      subtitle: 'Focus on cost per patient and resource utilization rates.',
      kpiCards: const [
        KPIConfig(label: 'OpEx p/ Patient', value: '\$142.50', trend: '-2.4%', color: Colors.green),
        KPIConfig(label: 'Asset ROI', value: '14.2%', trend: '+0.5%', color: Colors.blue),
        KPIConfig(label: 'Idle Resource Time', value: '4.1%', trend: 'Improving', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cost Breakdown Analysis', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Deep-dive charts breaking down the true operational cost of delivering distinct clinical services...'),
            ],
          ),
        ),
      ],
    );
  }
}

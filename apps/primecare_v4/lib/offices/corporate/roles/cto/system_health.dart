import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CtoSystemHealthScreen extends StatelessWidget {
  const CtoSystemHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'System Health',
      subtitle: 'Detailed micro-level service health checks and automated restart triggers.',
      kpiCards: const [
        KPIConfig(label: 'Global Node Health', value: '98%', trend: 'Stable', color: Colors.green),
        KPIConfig(label: 'Dead Letter Q', value: '1,420', trend: 'Warning', color: Colors.orange),
        KPIConfig(label: 'Auto-Restarts', value: '14', trend: 'Past 24H', color: Colors.blue),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Microservice Vitals', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive panel listing every PrimeCare Worker and container with their current memory/CPU load...'),
            ],
          ),
        ),
      ],
    );
  }
}

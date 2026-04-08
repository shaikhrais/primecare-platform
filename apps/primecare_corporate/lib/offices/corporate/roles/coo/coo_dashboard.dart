import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CooDashboardScreen extends StatelessWidget {
  const CooDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Operations Dashboard',
      subtitle:
          'Macro view of institutional efficiency, patient volumes, and network-wide bottlenecks.',
      kpiCards: const [
        KPIConfig(
          label: 'System Load',
          value: '82%',
          trend: 'Stable',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Resource Util',
          value: '91%',
          trend: 'High',
          color: Colors.orange,
        ),
        KPIConfig(
          label: 'NPS Score',
          value: '84',
          trend: '+2',
          color: Colors.green,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Network Vitality',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'High-level overview of enterprise-wide operational metrics, combining staffing with throughput...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CtoDashboardScreen extends StatelessWidget {
  const CtoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Engineering Dashboard',
      subtitle: 'High level metrics on system uptime, cloud spend vs budget, and active engineering incidents.',
      kpiCards: const [
        KPIConfig(label: 'Active Incidents', value: '0', trend: 'All Systems Go', color: Colors.green),
        KPIConfig(label: 'Cloud Spend', value: '\$14k/mo', trend: 'On Track', color: Colors.blue),
        KPIConfig(label: 'Open PRs', value: '18', trend: '+4', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Infrastructure Health', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('A comprehensive view of the PrimeCare cloud estate, mapping active VMs, DB loads, and container health...'),
            ],
          ),
        ),
      ],
    );
  }
}

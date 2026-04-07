import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class OpsDashboardScreen extends StatelessWidget {
  const OpsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'General Manager Operations Dashboard',
      subtitle: 'Overview of business development operations and partnerships.',
      kpiCards: const [
        KPIConfig(label: 'Total Partnerships', value: '42', trend: '+15%', color: Colors.blue),
        KPIConfig(label: 'Active Deals', value: '18', trend: '+5%', color: Colors.green),
        KPIConfig(label: 'Expansion Rate', value: '12%', trend: '+2%', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Recent Operations', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Internal task tracking and operational health...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Deal Pipeline Overview', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('High-level view of current business development pipeline...'),
            ],
          ),
        ),
      ],
    );
  }
}

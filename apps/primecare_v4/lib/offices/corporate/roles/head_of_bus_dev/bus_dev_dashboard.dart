import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class HeadOfBusDevDashboardScreen extends StatelessWidget {
  const HeadOfBusDevDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Business Development Dashboard',
      subtitle: 'Track pipeline value, newly signed franchise/B2B contracts, and upcoming corporate partnership deadlines.',
      kpiCards: const [
        KPIConfig(label: 'Pipeline Value', value: '\$14.2M', trend: 'Active', color: Colors.blue),
        KPIConfig(label: 'Signed L30 Days', value: '42', trend: '+14', color: Colors.green),
        KPIConfig(label: 'Deadlines < 7d', value: '3', trend: 'Action Req', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Global Sales Funnel', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive kanban view of all enterprise-level corporate partnerships in negotiation...'),
            ],
          ),
        ),
      ],
    );
  }
}

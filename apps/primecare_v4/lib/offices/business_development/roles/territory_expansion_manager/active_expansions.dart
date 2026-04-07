import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class ActiveExpansionsScreen extends StatelessWidget {
  const ActiveExpansionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Active Expansions',
      subtitle: 'Tracking ongoing clinic openings, real-estate acquisitions, and regulatory approvals.',
      kpiCards: const [
        KPIConfig(label: 'Clinics in Progress', value: '14', trend: '+3', color: Colors.blue),
        KPIConfig(label: 'Total CapEx', value: '\$12.5M', trend: 'On Budget', color: Colors.green),
        KPIConfig(label: 'Pending Approvals', value: '8', trend: '-2', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Project Portfolios', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive timeline of all current expansion projects...'),
            ],
          ),
        ),
      ],
    );
  }
}

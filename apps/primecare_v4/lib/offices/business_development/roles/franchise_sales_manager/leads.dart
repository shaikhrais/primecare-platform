import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class FranchiseLeadsScreen extends StatelessWidget {
  const FranchiseLeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Franchise Leads',
      subtitle: 'Kanban board for new franchise leads and qualification.',
      kpiCards: const [
        KPIConfig(label: 'Total Leads', value: '142', trend: '+25', color: Colors.blue),
        KPIConfig(label: 'Qualified Leads', value: '68', trend: '+12', color: Colors.green),
        KPIConfig(label: 'Uncontacted', value: '14', trend: 'Action Reqd', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lead Qualification Pipeline', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Kanban view: New -> Contacted -> Qualified -> Proposal...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lead Sources Overview', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Breakdown of where leads are originating from...'),
            ],
          ),
        ),
      ],
    );
  }
}

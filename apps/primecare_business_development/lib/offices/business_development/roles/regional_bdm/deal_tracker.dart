import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class DealTrackerScreen extends StatelessWidget {
  const DealTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Regional BDM Deal Tracker',
      subtitle: 'Track your regional deal pipeline and upcoming meetings.',
      kpiCards: const [
        KPIConfig(
          label: 'Total Deal Value',
          value: '\$1.2M',
          trend: '+15%',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Deals Won',
          value: '14',
          trend: '+3',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Deals Pending',
          value: '28',
          trend: 'Steady',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deal Pipeline',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Kanban view of Lead, Proposal, Negotiation, Closed deals...',
              ),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upcoming Meetings',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text('Upcoming proposals and negotiations...'),
            ],
          ),
        ),
      ],
    );
  }
}

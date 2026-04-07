import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class FranchiseProposalsScreen extends StatelessWidget {
  const FranchiseProposalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Active Proposals',
      subtitle: 'Manage commercial proposals and track negotiation stages.',
      kpiCards: const [
        KPIConfig(label: 'Active Proposals', value: '22', trend: '+4', color: Colors.blue),
        KPIConfig(label: 'Est. Closing Value', value: '\$2.4M', trend: '+15%', color: Colors.green),
        KPIConfig(label: 'In Legal Review', value: '3', trend: 'Steady', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Proposal Pipeline', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('List of proposals by stage: Draft, Sent, Negotiating, Won, Lost...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Document Status', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Tracking signatures and outstanding paperwork...'),
            ],
          ),
        ),
      ],
    );
  }
}

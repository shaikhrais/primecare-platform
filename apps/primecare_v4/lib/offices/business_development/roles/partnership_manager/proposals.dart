import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class PartnerProposalsScreen extends StatelessWidget {
  const PartnerProposalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Commercial Proposals',
      subtitle: 'Tracking outgoing partnership proposals and negotiation redlines.',
      kpiCards: const [
        KPIConfig(label: 'Proposals Out', value: '12', trend: '+3', color: Colors.blue),
        KPIConfig(label: 'In Redlining', value: '4', trend: 'Urgent', color: Colors.orange),
        KPIConfig(label: 'Pending Signature', value: '2', trend: 'Active', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Active Deal Proposals', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Detailed list of proposals tracking value, sent date, and current hold-up...'),
            ],
          ),
        ),
      ],
    );
  }
}

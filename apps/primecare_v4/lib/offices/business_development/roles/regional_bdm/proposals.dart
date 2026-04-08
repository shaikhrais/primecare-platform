import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class BDMProposalsScreen extends StatelessWidget {
  const BDMProposalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Commercial Proposals',
      subtitle: 'Draft and send commercial proposals and track views.',
      kpiCards: const [
        KPIConfig(label: 'Out for Sig', value: '8', trend: 'Pending', color: Colors.orange),
        KPIConfig(label: 'Signed', value: '42', trend: 'YTD', color: Colors.green),
        KPIConfig(label: 'Avg Value', value: '\$48k', trend: 'TCV', color: Colors.blue),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Contract Generation Engine', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('PDF staging area for MSA/SOW generation driven by dynamic CPQ algorithms...'),
            ],
          ),
        ),
      ],
    );
  }
}

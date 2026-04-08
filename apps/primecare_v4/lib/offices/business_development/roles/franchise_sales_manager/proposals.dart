import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class FranchiseProposalsScreen extends StatelessWidget {
  const FranchiseProposalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Financial Proposals',
      subtitle: 'Track drafted franchise disclosure documents and financial proposals sent to leads.',
      kpiCards: const [
        KPIConfig(label: 'Sent L30', value: '42', trend: 'Sent to Leads', color: Colors.blue),
        KPIConfig(label: 'View Rate', value: '81%', trend: 'Engagement', color: Colors.green),
        KPIConfig(label: 'Expiring', value: '5', trend: '< 7d to expiry', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Document Tracking', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Live status page monitoring prospect interactions with the FDD and customized financial models...'),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class PartnershipProposalsScreen extends StatelessWidget {
  const PartnershipProposalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'B2B Proposals',
      subtitle: 'Track drafted B2B service agreements and revenue share documents.',
      kpiCards: const [
        KPIConfig(label: 'Drafted', value: '41', trend: 'In Queue', color: Colors.blue),
        KPIConfig(label: 'Avg Rev Share', value: '14%', trend: 'Margin', color: Colors.green),
        KPIConfig(label: 'Legal Review', value: '4', trend: 'Pending', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Contract Generation', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Live feed of partnership documents entering legal compliance verification...'),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class FranchiseProspectsScreen extends StatelessWidget {
  const FranchiseProspectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'VIP Prospects',
      subtitle: 'Build target lists of VIP investors and physicians interested in franchising.',
      kpiCards: const [
        KPIConfig(label: 'Target List', value: '1,420', trend: 'Identified', color: Colors.blue),
        KPIConfig(label: 'Contacted', value: '14%', trend: 'Outreach', color: Colors.orange),
        KPIConfig(label: 'Qualified', value: '42', trend: 'High Value', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Account Strategy', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Account-based marketing lists linking high-net-worth healthcare investors to targeted regions...'),
            ],
          ),
        ),
      ],
    );
  }
}

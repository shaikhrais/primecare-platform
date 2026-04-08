import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class BDMPartnersScreen extends StatelessWidget {
  const BDMPartnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Regional Partnerships',
      subtitle: 'Manage regional integration partnerships and key strategic alliances.',
      kpiCards: const [
        KPIConfig(label: 'Active Alliances', value: '14', trend: 'Validated', color: Colors.blue),
        KPIConfig(label: 'Referral ROI', value: '8.4%', trend: 'Value', color: Colors.green),
        KPIConfig(label: 'Pending', value: '2', trend: 'Contract', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Alliance Roster', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive roster mapping tech vendors and regional clinical groups offering synergies...'),
            ],
          ),
        ),
      ],
    );
  }
}

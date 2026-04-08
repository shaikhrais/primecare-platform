import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class BDMClientsScreen extends StatelessWidget {
  const BDMClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Regional Clients',
      subtitle: 'Track all large B2B clients and key accounts in the region.',
      kpiCards: const [
        KPIConfig(label: 'Key Accounts', value: '42', trend: 'Managed', color: Colors.blue),
        KPIConfig(label: 'Avg LTV', value: '\$1.4M', trend: 'Projected', color: Colors.green),
        KPIConfig(label: 'At Risk', value: '2', trend: 'Review Req', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Book of Business', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive ledger of all signed B2B clients specific to the current region...'),
            ],
          ),
        ),
      ],
    );
  }
}

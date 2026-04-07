import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class FranchiseContractsScreen extends StatelessWidget {
  const FranchiseContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Franchise Contracts',
      subtitle: 'Manage active franchise contracts, pending renewals, and compliance.',
      kpiCards: const [
        KPIConfig(label: 'Active Contracts', value: '45', trend: '+2', color: Colors.blue),
        KPIConfig(label: 'Pending Renewals', value: '8', trend: 'Soon', color: Colors.orange),
        KPIConfig(label: 'Compliance Alerts', value: '1', trend: 'Urgent', color: Colors.red),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Active & Pending Contracts', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Detailed list of contracts with expiration dates and renewal status...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Legal & Compliance Status', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Outstanding compliance requirements for franchise partners...'),
            ],
          ),
        ),
      ],
    );
  }
}

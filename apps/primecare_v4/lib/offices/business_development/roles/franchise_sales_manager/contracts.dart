import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class FranchiseContractsScreen extends StatelessWidget {
  const FranchiseContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Contracts Dashboard',
      subtitle: 'Track franchise agreements, NDAs, and deal execution progression.',
      kpiCards: const [
        KPIConfig(label: 'Active Contracts', value: '14', trend: 'In Review', color: Colors.blue),
        KPIConfig(label: 'Pending NDAs', value: '8', trend: 'Awaiting Sig', color: Colors.orange),
        KPIConfig(label: 'Signed L30 Days', value: '3', trend: 'Executed', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Contract Execution Track', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Unified contract ledger tracking e-signatures and milestone compliance...'),
            ],
          ),
        ),
      ],
    );
  }
}

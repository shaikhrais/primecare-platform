import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CfoFranchiseFinancialsScreen extends StatelessWidget {
  const CfoFranchiseFinancialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Franchise Financials',
      subtitle:
          'Tracking royalty revenue, technology fees, and franchise audits.',
      kpiCards: const [
        KPIConfig(
          label: 'Total Royalties',
          value: '\$2.4M',
          trend: 'MTD',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Tech Fee Yield',
          value: '\$450k',
          trend: 'Stable',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Outstanding Dues',
          value: '\$112k',
          trend: 'High',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Franchise Yield Table',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Cross-tabulation of revenues collected vs projected across all franchise operators...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

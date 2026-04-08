import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CfoFinancialReportsScreen extends StatelessWidget {
  const CfoFinancialReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Financial Reports',
      subtitle: 'Formal 10-K/10-Q style documents, investor P&L statements, and audit packages.',
      kpiCards: const [
        KPIConfig(label: 'Audit Status', value: 'Clear', trend: 'Q3 Pending', color: Colors.green),
        KPIConfig(label: 'Draft Reports', value: '4', trend: 'Reviewing', color: Colors.blue),
        KPIConfig(label: 'Disclosures', value: '2', trend: 'Active', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Regulatory Filings', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Secure workspace for drafting and reviewing certified financial statements...'),
            ],
          ),
        ),
      ],
    );
  }
}

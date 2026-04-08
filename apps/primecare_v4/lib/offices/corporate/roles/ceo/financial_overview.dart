import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CeoFinancialOverviewScreen extends StatelessWidget {
  const CeoFinancialOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Financial Overview',
      subtitle: 'High-level dashboard highlighting EBITDA, Corporate run-rate, and cash reserves.',
      kpiCards: const [
        KPIConfig(label: 'EBITDA (Q3)', value: '\$45M', trend: '+12%', color: Colors.blue),
        KPIConfig(label: 'Cash on Hand', value: '\$112M', trend: 'Stable', color: Colors.green),
        KPIConfig(label: 'Burn Rate', value: '\$2.4M/mo', trend: '-0.2M', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Quarterly Financials', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive charts mapping revenue streams from franchises vs corporate owned clinics...'),
            ],
          ),
        ),
      ],
    );
  }
}

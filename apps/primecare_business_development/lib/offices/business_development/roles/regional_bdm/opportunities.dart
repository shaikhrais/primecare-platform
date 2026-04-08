import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class BDMOpportunitiesScreen extends StatelessWidget {
  const BDMOpportunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Current Opportunities (SQLs)',
      subtitle:
          'Track qualified sales qualified leads (SQLs) and their potential deal values.',
      kpiCards: const [
        KPIConfig(
          label: 'Total SQLs',
          value: '42',
          trend: 'Active',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Avg Deal Size',
          value: '\$14k',
          trend: 'L30 Days',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Stalled',
          value: '4',
          trend: 'Follow Up',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Opportunity Ledger',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Tracker linking qualified leads directly to forecasting revenue models and close dates...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

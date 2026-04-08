import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class PartnershipReportsScreen extends StatelessWidget {
  const PartnershipReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Partnership Revenue Reports',
      subtitle: 'View generated PDFs and revenue share metrics on clinical partnerships.',
      kpiCards: const [
        KPIConfig(label: 'Total Revenue', value: '\$14.2M', trend: 'YTD', color: Colors.blue),
        KPIConfig(label: 'Net Referer', value: '\$2.1M', trend: 'Disbursed', color: Colors.green),
        KPIConfig(label: 'Pending', value: '\$412k', trend: 'Ledger Audit', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Financial Exports', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Download center for historical ledger reports and hospital payout summaries...'),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CfoAccountsPayableScreen extends StatelessWidget {
  const CfoAccountsPayableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Accounts Payable',
      subtitle: 'Outstanding vendor payments, aging summaries, and pending large disbursements.',
      kpiCards: const [
        KPIConfig(label: 'Total A/P', value: '\$1.2M', trend: 'Due < 30 Days', color: Colors.orange),
        KPIConfig(label: 'Overdue Payments', value: '\$45k', trend: '+12k', color: Colors.red),
        KPIConfig(label: 'Early Pay Discounts', value: '\$8k', trend: 'Captured', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Vendor Disbursement Queue', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Detailed chronological list of approved and pending outgoing payments to suppliers and contractors...'),
            ],
          ),
        ),
      ],
    );
  }
}

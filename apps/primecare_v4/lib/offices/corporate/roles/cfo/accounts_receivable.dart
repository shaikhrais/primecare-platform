import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CfoAccountsReceivableScreen extends StatelessWidget {
  const CfoAccountsReceivableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Accounts Receivable',
      subtitle: 'Outstanding client invoices, aged receivables by 30/60/90 days, and collection actions.',
      kpiCards: const [
        KPIConfig(label: 'Total A/R', value: '\$4.5M', trend: '+1.2%', color: Colors.blue),
        KPIConfig(label: '90+ Days Overdue', value: '\$250k', trend: '-5%', color: Colors.orange),
        KPIConfig(label: 'Collection Rate', value: '94%', trend: 'Healthy', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Invoice Aging Chart', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Graphical representation of unpaid invoices stratified by age and client category...'),
            ],
          ),
        ),
      ],
    );
  }
}

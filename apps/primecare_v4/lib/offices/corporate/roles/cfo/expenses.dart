import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CfoExpensesScreen extends StatelessWidget {
  const CfoExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Operating Expenses',
      subtitle: 'Trailing 12 months operating expenses broken out by clinical vs administrative overhead.',
      kpiCards: const [
        KPIConfig(label: 'Total OPEX (T12M)', value: '\$18.4M', trend: '+4%', color: Colors.blue),
        KPIConfig(label: 'Clinical Share', value: '72%', trend: 'Stable', color: Colors.green),
        KPIConfig(label: 'Admin Overhead', value: '28%', trend: '-2%', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Expense Categorization', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Detailed stacked area chart showing real estate, payroll, IT infrastructure, and marketing spend...'),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CfoPayrollScreen extends StatelessWidget {
  const CfoPayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Enterprise Payroll',
      subtitle:
          'Macro-view of total enterprise payroll, clinical incentives, and executive bonuses.',
      kpiCards: const [
        KPIConfig(
          label: 'Total Headcount',
          value: '8,421',
          trend: '+115',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Payroll (M)',
          value: '\$42M',
          trend: 'Budgeted',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Overtime Cost',
          value: '\$1.2M',
          trend: '+15%',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Compensation Breakdown',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Interactive analysis of salary, benefits, and variable compensation across clinical vs administrative roles...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

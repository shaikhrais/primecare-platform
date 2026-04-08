import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CfoFinancialOverviewScreen extends StatelessWidget {
  const CfoFinancialOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Financial Overview',
      subtitle: 'Deep dive into EBITDA, margin compression, and debt-to-equity ratios.',
      kpiCards: const [
        KPIConfig(label: 'EBITDA (T12)', value: '\$45M', trend: '+12%', color: Colors.blue),
        KPIConfig(label: 'Operating Margin', value: '28%', trend: '+1.5%', color: Colors.green),
        KPIConfig(label: 'D/E Ratio', value: '1.4', trend: 'Stable', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Margin Analysis', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Trend lines mapping profitability metrics against market benchmarks...'),
            ],
          ),
        ),
      ],
    );
  }
}

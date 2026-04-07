import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CfoDashboardScreen extends StatelessWidget {
  const CfoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'CFO Dashboard',
      subtitle: 'Primary real-time overview of cash pool, short-term liabilities, and projected daily burns.',
      kpiCards: const [
        KPIConfig(label: 'Liquid Cash', value: '\$42M', trend: 'Stable', color: Colors.green),
        KPIConfig(label: 'Short-Term Debt', value: '\$14M', trend: 'Manageable', color: Colors.blue),
        KPIConfig(label: 'Current Ratio', value: '2.1', trend: '+0.2', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cash Flow Trajectory', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Consolidated graph of incoming cash flow against outgoing recurring burns and large CAPEX...'),
            ],
          ),
        ),
      ],
    );
  }
}

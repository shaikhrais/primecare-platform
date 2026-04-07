import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class ExpansionManagementScreen extends StatelessWidget {
  const ExpansionManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Expansion Management',
      subtitle: 'Detailed clinical business development management table showing staff allocations, budgeting, and timelines.',
      kpiCards: const [
        KPIConfig(label: 'Active Budgets', value: '25', trend: 'Active', color: Colors.blue),
        KPIConfig(label: 'Staffing Fill Rate', value: '68%', trend: '+5%', color: Colors.purple),
        KPIConfig(label: 'Avg Delay', value: '4 Days', trend: '-1 Day', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Resource Allocation Table', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Grid view showing resources assigned across all expansion regions...'),
            ],
          ),
        ),
      ],
    );
  }
}

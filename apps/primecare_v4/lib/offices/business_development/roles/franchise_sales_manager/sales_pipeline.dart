import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class FranchiseSalesPipelineScreen extends StatelessWidget {
  const FranchiseSalesPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Sales Pipeline',
      subtitle: 'Track franchise leads moving through the sales funnel stages.',
      kpiCards: const [
        KPIConfig(label: 'Total Leads', value: '412', trend: 'Active', color: Colors.blue),
        KPIConfig(label: 'Discovery', value: '84', trend: 'Stage 1', color: Colors.orange),
        KPIConfig(label: 'Closing', value: '14', trend: 'Stage 4', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Funnel Overview', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Visual funnel showing transition from initial outreach to contract execution...'),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class TerritoryExpansionDashboardScreen extends StatelessWidget {
  const TerritoryExpansionDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Territory Expansion Dashboard',
      subtitle: 'High-level KPIs merging new leases signed, site inspections, and budget burn rate.',
      kpiCards: const [
        KPIConfig(label: 'New Leases', value: '8', trend: 'Active', color: Colors.blue),
        KPIConfig(label: 'Burn Rate', value: '\$1.2M', trend: 'Monthly Focus', color: Colors.orange),
        KPIConfig(label: 'Inspections', value: '14', trend: 'Clear', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Executive Rollout Summary', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Aggregated rollup of property acquisitions and legal clearances for expanding franchise nodes...'),
            ],
          ),
        ),
      ],
    );
  }
}

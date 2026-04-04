import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class PartnerKpiDashboardScreen extends StatelessWidget {
  const PartnerKpiDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Partner Network KPI Board',
      subtitle: 'Key partner performance metrics and health scores.',
      kpiCards: const [
        KPIConfig(label: 'Network Health Score', value: '92/100', trend: '+2', color: Colors.green),
        KPIConfig(label: 'At Risk Partners', value: '3', trend: 'Review', color: Colors.red),
        KPIConfig(label: 'Top Performers', value: '14', trend: 'Steady', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Performance Distribution', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Chart showing the distribution of partners across engagement tiers...'),
            ],
          ),
        ),
      ],
    );
  }
}

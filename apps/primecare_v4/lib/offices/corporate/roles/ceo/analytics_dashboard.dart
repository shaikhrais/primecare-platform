import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CeoAnalyticsDashboardScreen extends StatelessWidget {
  const CeoAnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Analytics Dashboard',
      subtitle: 'High-level platform usage, user retention, and enterprise-wide health.',
      kpiCards: const [
        KPIConfig(label: 'Monthly Actives', value: '1.2M', trend: '+5%', color: Colors.blue),
        KPIConfig(label: 'Net Promoter Score', value: '72', trend: 'Excellent', color: Colors.green),
        KPIConfig(label: 'Customer LTV', value: '\$14k', trend: '+1.2%', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Macro Trends', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Big picture insights aggregated from millions of clinical and administrative touchpoints...'),
            ],
          ),
        ),
      ],
    );
  }
}

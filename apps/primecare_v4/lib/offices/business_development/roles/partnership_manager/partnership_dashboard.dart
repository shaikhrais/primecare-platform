import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class PartnershipDashboardScreen extends StatelessWidget {
  const PartnershipDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Partnerships Dashboard',
      subtitle: 'Track global partnership health, B2B referrers, and retention rates.',
      kpiCards: const [
        KPIConfig(label: 'Active Partners', value: '142', trend: 'Global', color: Colors.blue),
        KPIConfig(label: 'Referral Revenue', value: '\$4.1M', trend: 'YTD', color: Colors.green),
        KPIConfig(label: 'At Risk', value: '8', trend: 'Retention Alert', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('B2B Network Health', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Aggregated metrics on joint venture success, clinic referring patterns, and churn risk...'),
            ],
          ),
        ),
      ],
    );
  }
}

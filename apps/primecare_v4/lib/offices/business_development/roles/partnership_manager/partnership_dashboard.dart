import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class PartnershipDashboardScreen extends StatelessWidget {
  const PartnershipDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Partnership Dashboard',
      subtitle: 'Management of active partnerships and at-risk accounts.',
      kpiCards: const [
        KPIConfig(label: 'Total Partners', value: '156', trend: '+8%', color: Colors.blue),
        KPIConfig(label: 'At-Risk Accounts', value: '3', trend: '-2', color: Colors.red),
        KPIConfig(label: 'New Leads', value: '24', trend: '+12%', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Active Partnerships', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Contract dates and health scores table goes here...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Recent Communications', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Activity feed with partners...'),
            ],
          ),
        ),
      ],
    );
  }
}

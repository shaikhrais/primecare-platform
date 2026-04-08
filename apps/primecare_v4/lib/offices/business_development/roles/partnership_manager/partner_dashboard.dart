import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class PartnerPortalDashboardScreen extends StatelessWidget {
  const PartnerPortalDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Partner Portal View',
      subtitle: 'Provide a portal interface for partners to view their own referral metrics and payout history.',
      kpiCards: const [
        KPIConfig(label: 'Active Logins', value: '4.2k', trend: 'L30 Days', color: Colors.blue),
        KPIConfig(label: 'Payouts', value: '\$142k', trend: 'Disbursed', color: Colors.green),
        KPIConfig(label: 'Support Tix', value: '12', trend: 'Open', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('External Portal Metrics', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Admin overview of how often external partners engage with their dedicated dashboards...'),
            ],
          ),
        ),
      ],
    );
  }
}

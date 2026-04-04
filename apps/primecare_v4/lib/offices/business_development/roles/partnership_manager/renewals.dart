import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class PartnerRenewalsScreen extends StatelessWidget {
  const PartnerRenewalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Contract Renewals & QBRs',
      subtitle: 'Timeline of upcoming partnership renewals and scheduled reviews.',
      kpiCards: const [
        KPIConfig(label: 'Expiring < 90 Days', value: '6', trend: 'Action Reqd', color: Colors.orange),
        KPIConfig(label: 'QBRs Scheduled', value: '4', trend: 'This Month', color: Colors.blue),
        KPIConfig(label: 'Projected Upsell', value: '\$150k', trend: '+12%', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Renewal Timeline', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Visual timeline of contract expiration dates targeting early renewal...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Quarterly Business Reviews', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Schedule and notes for upcoming performance review meetings...'),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class BDMCampaignsScreen extends StatelessWidget {
  const BDMCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Regional Campaigns',
      subtitle: 'Track regional marketing and out-sourcing campaigns.',
      kpiCards: const [
        KPIConfig(label: 'Active Campaigns', value: '8', trend: 'Live', color: Colors.blue),
        KPIConfig(label: 'Total Spend', value: '\$14k', trend: 'Monthly', color: Colors.orange),
        KPIConfig(label: 'ROI', value: '4.2x', trend: 'Avg', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Campaign Tracker', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Monitor Google Ads, trade show lists, and cold email outreach sequences...'),
            ],
          ),
        ),
      ],
    );
  }
}

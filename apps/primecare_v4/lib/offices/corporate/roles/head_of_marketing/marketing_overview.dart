import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class HeadOfMarketingOverviewScreen extends StatelessWidget {
  const HeadOfMarketingOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Marketing Overview',
      subtitle: 'Track brand vitality, multi-channel B2C campaign performance, and regional patient acquisition costs.',
      kpiCards: const [
        KPIConfig(label: 'Global CAC', value: '\$42.50', trend: '-12%', color: Colors.green),
        KPIConfig(label: 'Active Campaigns', value: '14', trend: 'Live', color: Colors.blue),
        KPIConfig(label: 'Brand Vitality', value: '84/100', trend: 'Strong', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Channel Performance', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Real-time comparison of SEO, digital ad spending, and physical affiliate ROI against patient conversions...'),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CfoRevenueScreen extends StatelessWidget {
  const CfoRevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Revenue Analysis',
      subtitle: 'Outlining B2C client cash payments, insurance payouts, and B2B corporate contracts.',
      kpiCards: const [
        KPIConfig(label: 'Total Revenue', value: '\$142M', trend: 'YTD', color: Colors.blue),
        KPIConfig(label: 'Insurance', value: '45%', trend: 'Decreasing', color: Colors.orange),
        KPIConfig(label: 'B2B Corporate', value: '30%', trend: 'Increasing', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Revenue Stream Breakdown', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Sankey chart visualizing the flow of cash from various payer sources into corporate accounts...'),
            ],
          ),
        ),
      ],
    );
  }
}

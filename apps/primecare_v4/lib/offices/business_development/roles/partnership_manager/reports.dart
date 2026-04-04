import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class PartnerReportsScreen extends StatelessWidget {
  const PartnerReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Partnership Analytics',
      subtitle: 'Financial and strategic metrics generated from the partner network.',
      kpiCards: const [
        KPIConfig(label: 'Referral Revenue', value: '\$840k', trend: '+8%', color: Colors.green),
        KPIConfig(label: 'Marketing ROI', value: '2.4x', trend: '+0.2x', color: Colors.blue),
        KPIConfig(label: 'Partner Originated', value: '35%', trend: 'Steady', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Revenue Attribution', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Charts breaking down revenue directly sourced from our partnership network...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Joint Marketing Performance', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Analytics mapping joint campaign spend vs resulting acquisitions...'),
            ],
          ),
        ),
      ],
    );
  }
}

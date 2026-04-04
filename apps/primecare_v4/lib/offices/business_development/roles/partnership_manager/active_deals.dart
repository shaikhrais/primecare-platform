import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class PartnerActiveDealsScreen extends StatelessWidget {
  const PartnerActiveDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Active Partnership Deals',
      subtitle: 'Pipeline of B2B partnership opportunities and deal stages.',
      kpiCards: const [
        KPIConfig(label: 'Total Deal Value', value: '\$1.2M', trend: '+5%', color: Colors.blue),
        KPIConfig(label: 'Deals in Negotiation', value: '8', trend: 'Active', color: Colors.orange),
        KPIConfig(label: 'Avg Closing Time', value: '45d', trend: '-2d', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Partnership Pipeline', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Kanban view mapping prospects from initial pitch to signed agreement...'),
            ],
          ),
        ),
      ],
    );
  }
}

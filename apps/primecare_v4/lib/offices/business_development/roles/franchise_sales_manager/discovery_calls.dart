import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class FranchiseDiscoveryCallsScreen extends StatelessWidget {
  const FranchiseDiscoveryCallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Discovery Calls',
      subtitle: 'Track scheduled introductory meetings with potential franchisees and key talking points.',
      kpiCards: const [
        KPIConfig(label: 'Calls Today', value: '4', trend: 'Scheduled', color: Colors.blue),
        KPIConfig(label: 'Conversion', value: '38%', trend: 'To Stage 2', color: Colors.green),
        KPIConfig(label: 'No-Shows', value: '12%', trend: 'L30 Days', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Upcoming Consultations', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive schedule detailing booked discovery meetings and prospect background...'),
            ],
          ),
        ),
      ],
    );
  }
}

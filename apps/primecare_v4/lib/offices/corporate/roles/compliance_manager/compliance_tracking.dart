import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class ComplianceTrackingScreen extends StatelessWidget {
  const ComplianceTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Regulatory Tracking',
      subtitle: 'Track regulatory adherence across multiple regions and facility types.',
      kpiCards: const [
        KPIConfig(label: 'Total Regions', value: '6', trend: 'Compliant', color: Colors.blue),
        KPIConfig(label: 'Policy Updates', value: '11', trend: 'Pending ACK', color: Colors.orange),
        KPIConfig(label: 'Non-Conformities', value: '0', trend: 'Target Met', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Jurisdiction Matrix', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Cross-referencing organizational policies against state/provincial healthcare regulations...'),
            ],
          ),
        ),
      ],
    );
  }
}

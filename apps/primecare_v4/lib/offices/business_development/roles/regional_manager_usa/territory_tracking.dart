import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class UsaTerritoryTrackingScreen extends StatelessWidget {
  const UsaTerritoryTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Territory Tracking: USA',
      subtitle: 'Granular view of US State performance and expansion progress.',
      kpiCards: const [
        KPIConfig(label: 'State Saturation', value: '4%', trend: '+1%', color: Colors.blue),
        KPIConfig(label: 'New Territories', value: '2', trend: 'Active', color: Colors.green),
        KPIConfig(label: 'Competitor Clinics', value: '340', trend: 'Vast', color: Colors.red),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Demographic Overlaps', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Mapping patient density against our current pilot locations...'),
            ],
          ),
        ),
      ],
    );
  }
}

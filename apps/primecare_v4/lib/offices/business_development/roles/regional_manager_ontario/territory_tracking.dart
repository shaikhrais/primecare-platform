import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class OntarioTerritoryTrackingScreen extends StatelessWidget {
  const OntarioTerritoryTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Territory Tracking: Ontario',
      subtitle: 'Granular view of GTA and surrounding regions performance.',
      kpiCards: const [
        KPIConfig(label: 'GTA Saturation', value: '62%', trend: '+4%', color: Colors.blue),
        KPIConfig(label: 'New Territories', value: '3', trend: 'Active', color: Colors.green),
        KPIConfig(label: 'Competitor Clinics', value: '18', trend: 'Stable', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Demographic Overlaps', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Mapping patient density against our current clinic locations...'),
            ],
          ),
        ),
      ],
    );
  }
}

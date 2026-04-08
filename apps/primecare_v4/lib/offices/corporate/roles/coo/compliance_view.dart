import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CooComplianceViewScreen extends StatelessWidget {
  const CooComplianceViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Operational Compliance',
      subtitle: 'Map out region-level operational compliance scores focusing on physical plant and safety.',
      kpiCards: const [
        KPIConfig(label: 'Plant Safety', value: '98%', trend: 'Passing', color: Colors.green),
        KPIConfig(label: 'HVAC/Env', value: '94%', trend: 'Operational', color: Colors.blue),
        KPIConfig(label: 'Open Work Orders', value: '142', trend: 'Prio 1/2/3', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Physical Plant Readiness', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Real-time tracking of building maintenance, biomedical device calibrations, and environment factors...'),
            ],
          ),
        ),
      ],
    );
  }
}

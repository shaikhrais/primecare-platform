import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class OntarioLayoutScreen extends StatelessWidget {
  const OntarioLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Ontario Regional Hub',
      subtitle: 'Centralized tools and metrics for the Ontario Territory.',
      kpiCards: const [
        KPIConfig(label: 'Active Facilities', value: '42', trend: '+3', color: Colors.blue),
        KPIConfig(label: 'Compliance Rate', value: '98%', trend: 'Stable', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Navigation & Setup', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('This shell wraps all other Ontario management screens...'),
            ],
          ),
        ),
      ],
    );
  }
}

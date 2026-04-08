import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class RegionalBdmReportsScreen extends StatelessWidget {
  const RegionalBdmReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Field Reports & Quota Tracker',
      subtitle: 'Monthly activity reports, quota attainment, and expense tracking.',
      kpiCards: const [
        KPIConfig(label: 'Quota Attainment', value: '82%', trend: 'On Track', color: Colors.green),
        KPIConfig(label: 'Monthly Activity', value: '144 pts', trend: '+12', color: Colors.blue),
        KPIConfig(label: 'Travel Budget', value: '45%', trend: 'Under', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Quota Attainment Curve', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Line chart matching current sales vs expected quota for the quarter...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Field Expenses Review', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Breakdown of T&E against ROI generated...'),
            ],
          ),
        ),
      ],
    );
  }
}

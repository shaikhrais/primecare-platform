import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class NewClinicsScreen extends StatelessWidget {
  const NewClinicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'New Clinics',
      subtitle: 'Tracking the onboarding progress of recently launched clinic branches.',
      kpiCards: const [
        KPIConfig(label: 'Clinics Opened (YTD)', value: '6', trend: '+2', color: Colors.blue),
        KPIConfig(label: 'Avg Launch Time', value: '110 Days', trend: '-5 Days', color: Colors.green),
        KPIConfig(label: 'Pre-registered Patients', value: '450', trend: '+15%', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Onboarding Checklists', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Status of IT provisioning, staff hiring, and marketing campaigns for upcoming branches...'),
            ],
          ),
        ),
      ],
    );
  }
}

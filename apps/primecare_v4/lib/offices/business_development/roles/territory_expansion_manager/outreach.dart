import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class TerritoryOutreachScreen extends StatelessWidget {
  const TerritoryOutreachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Municipal Outreach',
      subtitle: 'Log interactions with local government zoning boards and land developers.',
      kpiCards: const [
        KPIConfig(label: 'Zoning Apps', value: '14', trend: 'Pending', color: Colors.orange),
        KPIConfig(label: 'Approved', value: '38', trend: 'YTD', color: Colors.green),
        KPIConfig(label: 'Meetings', value: '24', trend: 'Next 30 Days', color: Colors.blue),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Government & Real Estate Relations', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('CRM tailored for tracking bureaucratic lobbying and commercial real estate negotiations...'),
            ],
          ),
        ),
      ],
    );
  }
}

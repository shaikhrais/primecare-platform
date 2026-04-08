import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class PartnerManagementScreen extends StatelessWidget {
  const PartnerManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Partner Administration',
      subtitle:
          'Handle administrative tasks like onboarding new clinics, updating contracts, and SLA monitoring.',
      kpiCards: const [
        KPIConfig(
          label: 'Onboarding',
          value: '14',
          trend: 'In Progress',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'SLA Breaches',
          value: '2',
          trend: 'Review Req',
          color: Colors.red,
        ),
        KPIConfig(
          label: 'Completed',
          value: '38',
          trend: 'YTD',
          color: Colors.green,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Onboarding Tasks',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Automated task checklists aligned to launching newly signed syndication partners...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class UsaLayoutScreen extends StatelessWidget {
  const UsaLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'USA Expansion Hub',
      subtitle: 'Centralized tools and metrics for the US Expansion territory.',
      kpiCards: const [
        KPIConfig(
          label: 'Active Facilities',
          value: '12',
          trend: '+2',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Compliance Rate',
          value: '100%',
          trend: 'Perfect',
          color: Colors.green,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Navigation & Setup',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'This shell wraps all other US Expansion management screens...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

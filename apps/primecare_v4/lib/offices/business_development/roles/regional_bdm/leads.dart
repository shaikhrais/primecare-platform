import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class BDMLeadsScreen extends StatelessWidget {
  const BDMLeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Lead Management',
      subtitle: 'View and organize raw leads generated from campaigns.',
      kpiCards: const [
        KPIConfig(label: 'New Leads', value: '412', trend: 'This Week', color: Colors.blue),
        KPIConfig(label: 'Conversion', value: '8.4%', trend: 'To MQL', color: Colors.green),
        KPIConfig(label: 'Stale Leads', value: '1,041', trend: 'L90 Days', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lead Inbox', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Triaging center for all raw prospect contact information gathered across channels...'),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class RegionalUSADashboardScreen extends StatelessWidget {
  const RegionalUSADashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'USA Operations Metrics',
      subtitle: 'Provides deep-dive operational metrics and compliance tracking specific to US health regulations (HIPAA/Medicare).',
      kpiCards: const [
        KPIConfig(label: 'Medicare Rejections', value: '14', trend: 'Resolving', color: Colors.blue),
        KPIConfig(label: 'HIPAA Audits', value: '2', trend: 'Pending', color: Colors.orange),
        KPIConfig(label: 'Compliance', value: '98%', trend: 'Score', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Regulatory Compliance', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Tracker for state-by-state billing enrollments and HIPAA security certifications...'),
            ],
          ),
        ),
      ],
    );
  }
}

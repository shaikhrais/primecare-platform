import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CfoReportsScreen extends StatelessWidget {
  const CfoReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'General Reporting',
      subtitle:
          'Comprehensive financial reporting library and automated analysis tools.',
      kpiCards: const [
        KPIConfig(
          label: 'Custom Reports',
          value: '18',
          trend: 'Generated',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Scheduled',
          value: '4',
          trend: 'Weekly',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Data Sync',
          value: 'Live',
          trend: '100%',
          color: Colors.purple,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reporting Engine',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Dynamic interface for dragging and dropping data points to construct P&L analyses...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

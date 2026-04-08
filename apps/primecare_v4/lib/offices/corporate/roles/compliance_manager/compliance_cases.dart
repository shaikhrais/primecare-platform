import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class ComplianceCasesScreen extends StatelessWidget {
  const ComplianceCasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Case Resolution',
      subtitle: 'Track whistleblower reports, labor disputes, and severe protocol breaches.',
      kpiCards: const [
        KPIConfig(label: 'Open Cases', value: '8', trend: '-2', color: Colors.orange),
        KPIConfig(label: 'Critical Priority', value: '1', trend: 'Urgent', color: Colors.red),
        KPIConfig(label: 'Avg Resolution', value: '14 Days', trend: '-3 Days', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Active Investigations', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Secure, localized incident resolution portal restricted to compliance officers...'),
            ],
          ),
        ),
      ],
    );
  }
}

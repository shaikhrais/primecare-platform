import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class TrainingReportsScreen extends StatelessWidget {
  const TrainingReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Training Reports',
      subtitle: 'Generate audit-ready educational logs for hospital partners.',
      kpiCards: const [
        KPIConfig(label: 'Reports Run', value: '1,420', trend: 'L30 Days', color: Colors.blue),
        KPIConfig(label: 'Partner Audits', value: '12', trend: 'Pending', color: Colors.orange),
        KPIConfig(label: 'Export Rate', value: '99.9%', trend: 'Success', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Audit Generation', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Automated tool to compile individual staff transcripts into macro-level compliance PDFs for external review...'),
            ],
          ),
        ),
      ],
    );
  }
}

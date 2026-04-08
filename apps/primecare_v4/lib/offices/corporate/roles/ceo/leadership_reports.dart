import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CeoLeadershipReportsScreen extends StatelessWidget {
  const CeoLeadershipReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Leadership Reports',
      subtitle: 'Automated 1-page summaries submitted by the CFO, COO, CTO, and other executives.',
      kpiCards: const [
        KPIConfig(label: 'Pending Reports', value: '0', trend: 'Complete', color: Colors.green),
        KPIConfig(label: 'Exec Alignments', value: '8', trend: 'Scheduled', color: Colors.blue),
        KPIConfig(label: 'Emerging Issues', value: '3', trend: 'Minor', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('C-Suite Summaries', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Grid of easily digestible one-pagers detailing the operational status for each major department...'),
            ],
          ),
        ),
      ],
    );
  }
}

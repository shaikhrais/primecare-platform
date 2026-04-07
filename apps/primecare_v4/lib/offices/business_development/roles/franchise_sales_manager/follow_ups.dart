import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class FranchiseFollowUpsScreen extends StatelessWidget {
  const FranchiseFollowUpsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Prospect Follow Ups',
      subtitle: 'Tracker for prospect engagement and next actions.',
      kpiCards: const [
        KPIConfig(label: 'Pending Follow Ups', value: '28', trend: 'High', color: Colors.orange),
        KPIConfig(label: 'Avg Response Time', value: '4hrs', trend: '-30m', color: Colors.green),
        KPIConfig(label: 'Engagement Score', value: '78/100', trend: '+5', color: Colors.blue),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Engagement Timeline', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Chronological history of communications and touchpoints...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Next Action Items', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('List of due actions to progress the prospect...'),
            ],
          ),
        ),
      ],
    );
  }
}

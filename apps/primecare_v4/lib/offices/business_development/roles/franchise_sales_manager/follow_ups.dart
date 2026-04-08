import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class FranchiseFollowUpsScreen extends StatelessWidget {
  const FranchiseFollowUpsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Follow-Ups',
      subtitle: 'Track post-meeting tasks, email sequences, and re-engagement campaigns.',
      kpiCards: const [
        KPIConfig(label: 'Due Today', value: '24', trend: 'Tasks', color: Colors.orange),
        KPIConfig(label: 'Sequence Reply', value: '41%', trend: 'Engagement', color: Colors.blue),
        KPIConfig(label: 'Completed', value: '100%', trend: 'L7 Days', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Task Re-engagement Board', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Actionable list of warm leads requiring post-discovery collateral or phone follow-up...'),
            ],
          ),
        ),
      ],
    );
  }
}

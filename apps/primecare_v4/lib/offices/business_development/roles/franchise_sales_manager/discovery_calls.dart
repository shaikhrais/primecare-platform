import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class FranchiseDiscoveryCallsScreen extends StatelessWidget {
  const FranchiseDiscoveryCallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Discovery Calls',
      subtitle: 'Schedule and manage upcoming prospect calls.',
      kpiCards: const [
        KPIConfig(label: 'Scheduled Calls', value: '12', trend: 'This Week', color: Colors.blue),
        KPIConfig(label: 'Conversion Rate', value: '25%', trend: '+4%', color: Colors.green),
        KPIConfig(label: 'Missed Calls', value: '2', trend: '-1', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Upcoming Calls', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Timeline view of today\'s calls with prospect profiles...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Call Scripts & Hints', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Embedded scripts tailored to the current prospect\'s industry...'),
            ],
          ),
        ),
      ],
    );
  }
}

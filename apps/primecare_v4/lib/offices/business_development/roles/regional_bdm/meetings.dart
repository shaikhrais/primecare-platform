import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class RegionalBdmMeetingsScreen extends StatelessWidget {
  const RegionalBdmMeetingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Meetings & Syncs',
      subtitle: 'Schedule of client meetings, discovery days, and virtual check-ins.',
      kpiCards: const [
        KPIConfig(label: 'Meetings This Week', value: '18', trend: '+4', color: Colors.blue),
        KPIConfig(label: 'Discovery Days', value: '2', trend: 'Soon', color: Colors.orange),
        KPIConfig(label: 'Held Rate', value: '94%', trend: 'Steady', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Upcoming Calendar', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive weekly calendar detailing times, links, and attendees...'),
            ],
          ),
        ),
      ],
    );
  }
}

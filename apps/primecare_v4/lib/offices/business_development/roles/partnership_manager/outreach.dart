import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class PartnerOutreachScreen extends StatelessWidget {
  const PartnerOutreachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'B2B Outreach Tracking',
      subtitle: 'Monitor initial contacts and email sequence performance.',
      kpiCards: const [
        KPIConfig(label: 'Emails Sent (This Wk)', value: '1,204', trend: '+120', color: Colors.blue),
        KPIConfig(label: 'Open Rate', value: '42%', trend: '+3%', color: Colors.green),
        KPIConfig(label: 'Reply Rate', value: '8.4%', trend: 'Steady', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Active Sequences', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('List of current email sequences, target audiences, and performance metrics...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Engagement Log', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Recent B2B responses, bounced emails, and requested follows-ups...'),
            ],
          ),
        ),
      ],
    );
  }
}

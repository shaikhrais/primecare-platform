import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class ExpansionOutreachScreen extends StatelessWidget {
  const ExpansionOutreachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Expansion Outreach',
      subtitle: 'Tracking communication with local stakeholders, real estate agents, and government health officials.',
      kpiCards: const [
        KPIConfig(label: 'Stakeholders Contacted', value: '142', trend: '+12', color: Colors.blue),
        KPIConfig(label: 'Meetings Scheduled', value: '38', trend: 'Active', color: Colors.purple),
        KPIConfig(label: 'Positive Feedback', value: '75%', trend: '+5%', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Communication Log', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Chronological list of emails, calls, and meetings with local expansion partners...'),
            ],
          ),
        ),
      ],
    );
  }
}

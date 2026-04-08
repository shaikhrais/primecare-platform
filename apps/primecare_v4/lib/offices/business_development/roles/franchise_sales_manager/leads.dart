import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class FranchiseLeadsScreen extends StatelessWidget {
  const FranchiseLeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Lead Inbox',
      subtitle: 'Track raw inbound franchise inquiries and marketing qualified prospects.',
      kpiCards: const [
        KPIConfig(label: 'New Leads', value: '84', trend: 'Unopened', color: Colors.blue),
        KPIConfig(label: 'MQL Rate', value: '28%', trend: 'Qualified', color: Colors.green),
        KPIConfig(label: 'Junk Rate', value: '14%', trend: 'Spam/Low Fit', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lead Routing Feed', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Incoming prospect forms generated from web channels and territory marketing initiatives...'),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class HeadOfBusDevGlobalLeadsScreen extends StatelessWidget {
  const HeadOfBusDevGlobalLeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Global Leads (CRM)',
      subtitle: 'Track outbound enterprise partnership leads and B2B hospital integrations.',
      kpiCards: const [
        KPIConfig(label: 'Total Leads', value: '14,210', trend: 'Global Database', color: Colors.blue),
        KPIConfig(label: 'Converted', value: '4.2%', trend: '+0.5%', color: Colors.green),
        KPIConfig(label: 'Cold L90 Days', value: '4,100', trend: 'Re-engage', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enterprise CRM Feed', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Unified table tracking touchpoints, email campaigns, and upcoming meeting schedules for high-value targets...'),
            ],
          ),
        ),
      ],
    );
  }
}

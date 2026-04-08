import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CtoIntegrationsScreen extends StatelessWidget {
  const CtoIntegrationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Integrations Hub',
      subtitle: 'Track connectivity with external labs, pharmacies, and legacy hospital systems.',
      kpiCards: const [
        KPIConfig(label: 'Active Webhooks', value: '84', trend: 'Live Status', color: Colors.blue),
        KPIConfig(label: 'Sync Failures', value: '12', trend: '< 0.05%', color: Colors.orange),
        KPIConfig(label: 'Data Processed', value: '4.2 TB', trend: 'This Month', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('External Topology', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive node graph showing data flow between the PrimeCare data warehouse and key external partners...'),
            ],
          ),
        ),
      ],
    );
  }
}

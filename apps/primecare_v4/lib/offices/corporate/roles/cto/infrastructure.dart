import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CtoInfrastructureScreen extends StatelessWidget {
  const CtoInfrastructureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Infrastructure',
      subtitle: 'Manage cloud assets, server health, and geographical redundancies.',
      kpiCards: const [
        KPIConfig(label: 'Total Clusters', value: '14', trend: 'Global', color: Colors.blue),
        KPIConfig(label: 'DB Replicas', value: '42', trend: 'Healthy', color: Colors.green),
        KPIConfig(label: 'Storage Used', value: '84%', trend: 'Scale Up Req', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cloud Topology', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Visual diagram of the PrimeCare cloud architecture showing region-based routing and database shards...'),
            ],
          ),
        ),
      ],
    );
  }
}

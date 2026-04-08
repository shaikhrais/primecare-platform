import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CtoPlatformUsageScreen extends StatelessWidget {
  const CtoPlatformUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Platform Usage',
      subtitle: 'Track peak concurrent user loads and bandwidth utilization.',
      kpiCards: const [
        KPIConfig(label: 'Concurrent Users', value: '4,210', trend: 'Peak 4,800', color: Colors.blue),
        KPIConfig(label: 'Bandwidth', value: '1.2 GB/s', trend: 'Stable', color: Colors.green),
        KPIConfig(label: 'Database Load', value: '42%', trend: 'Nominal', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Capacity Analytics', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Real-time timeline tracking usage spikes correlated with shift changes and batch processes...'),
            ],
          ),
        ),
      ],
    );
  }
}

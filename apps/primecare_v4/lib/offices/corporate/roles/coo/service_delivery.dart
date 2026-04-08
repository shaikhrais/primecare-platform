import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CooServiceDeliveryScreen extends StatelessWidget {
  const CooServiceDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Service Delivery',
      subtitle: 'Analyze clinical outcomes versus operational delays.',
      kpiCards: const [
        KPIConfig(label: 'On-Time Starts', value: '94%', trend: 'Target: 95%', color: Colors.orange),
        KPIConfig(label: 'Avg Delay', value: '11 mins', trend: '-2 mins', color: Colors.green),
        KPIConfig(label: 'Client Sat', value: '4.8/5', trend: 'High', color: Colors.blue),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Service Delay Analysis', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Tracing operational bottlenecks to evaluate their direct impact on clinical outcome scoring...'),
            ],
          ),
        ),
      ],
    );
  }
}

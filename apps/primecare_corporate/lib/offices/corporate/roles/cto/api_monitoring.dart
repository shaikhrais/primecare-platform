import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CtoApiMonitoringScreen extends StatelessWidget {
  const CtoApiMonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'API Monitoring',
      subtitle: 'Track throughput and error rates for patient data syncing.',
      kpiCards: const [
        KPIConfig(
          label: 'Uptime',
          value: '99.98%',
          trend: 'Target Met',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Avg Latency',
          value: '114ms',
          trend: '-12ms',
          color: Colors.blue,
        ),
        KPIConfig(
          label: '4xx/5xx Errors',
          value: '0.01%',
          trend: 'Stable',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gateway Throughput',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Interactive tracing to monitor latency and load on critical PrimeCare microservices...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CfoInvoicesScreen extends StatelessWidget {
  const CfoInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Enterprise Invoices',
      subtitle:
          'Real-time generation of custom billing for corporate clients and insurers.',
      kpiCards: const [
        KPIConfig(
          label: 'Invoices Generated',
          value: '412',
          trend: 'Today',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Unbilled Events',
          value: '24',
          trend: 'Processing',
          color: Colors.orange,
        ),
        KPIConfig(
          label: 'Avg Processing',
          value: '1.2h',
          trend: '-0.1h',
          color: Colors.green,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Billing Queue Engine',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Monitoring the automated pipeline converting clinical charts into complex enterprise invoices...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

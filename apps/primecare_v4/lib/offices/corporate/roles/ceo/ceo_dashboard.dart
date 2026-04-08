import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CeoDashboardScreen extends StatelessWidget {
  const CeoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'CEO Dashboard',
      subtitle:
          'Primary homepage featuring a high-level snapshot of business performance.',
      kpiCards: const [
        KPIConfig(
          label: 'Total Assets',
          value: '\$1.4B',
          trend: 'Growing',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Net Margin',
          value: '22%',
          trend: '+1.5%',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Headcount',
          value: '8,400',
          trend: '+120',
          color: Colors.purple,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Executive Summary',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Unified snapshot of performance across Corporate, Clinic, Client, and Franchised channels...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

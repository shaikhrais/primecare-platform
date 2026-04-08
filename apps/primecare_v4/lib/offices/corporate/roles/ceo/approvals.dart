import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CeoApprovalsScreen extends StatelessWidget {
  const CeoApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Executive Approvals',
      subtitle:
          'Sign-offs for large-scale acquisitions, budgets, and key executive hiring.',
      kpiCards: const [
        KPIConfig(
          label: 'Pending Approvals',
          value: '4',
          trend: 'Action Req',
          color: Colors.orange,
        ),
        KPIConfig(
          label: 'Value at Stake',
          value: '\$24M',
          trend: 'High',
          color: Colors.purple,
        ),
        KPIConfig(
          label: 'Avg Turnaround',
          value: '1.2 Days',
          trend: '-0.3 Days',
          color: Colors.green,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Action Queue',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'List of requests requiring CEO signature or explicit authorization...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

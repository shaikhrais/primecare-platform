import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class PartnershipOutreachScreen extends StatelessWidget {
  const PartnershipOutreachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'B2B Outreach',
      subtitle:
          'Track email campaigns and cold calls directed at hospital decision makers.',
      kpiCards: const [
        KPIConfig(
          label: 'Emails Sent',
          value: '4,102',
          trend: 'L30 Days',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Open Rate',
          value: '38%',
          trend: 'Above Avg',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Bounce Rate',
          value: '4.2%',
          trend: 'Monitor',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Outreach Performance',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Detailed analytics on cadence execution, cold call metrics, and meeting book rates...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

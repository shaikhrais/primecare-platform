import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CompliancePoliciesScreen extends StatelessWidget {
  const CompliancePoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Policy Management',
      subtitle: 'Track the distribution, signatures, and acknowledgement of new corporate compliance policies.',
      kpiCards: const [
        KPIConfig(label: 'Active Policies', value: '142', trend: 'Published', color: Colors.blue),
        KPIConfig(label: 'Pending Ack', value: '840', trend: 'Staff Members', color: Colors.orange),
        KPIConfig(label: 'Adoption Rate', value: '92%', trend: '+4%', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Distribution Campaigns', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Tracking system for ensuring clinical staff acknowledge and digitally sign updated procedural manuals...'),
            ],
          ),
        ),
      ],
    );
  }
}

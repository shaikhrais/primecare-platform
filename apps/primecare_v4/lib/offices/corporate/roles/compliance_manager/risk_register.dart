import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class ComplianceRiskRegisterScreen extends StatelessWidget {
  const ComplianceRiskRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Risk Register',
      subtitle: 'Map out high, medium, and low probability risks based on recent audits.',
      kpiCards: const [
        KPIConfig(label: 'Tracked Risks', value: '412', trend: '+14', color: Colors.blue),
        KPIConfig(label: 'High Probability', value: '18', trend: 'Critical', color: Colors.red),
        KPIConfig(label: 'Mitigated', value: '84', trend: 'This Quarter', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Probability/Impact Matrix', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive heat map plotting organizational vulnerabilities by likelihood and severity...'),
            ],
          ),
        ),
      ],
    );
  }
}

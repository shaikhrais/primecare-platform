import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CeoOrganizationMapScreen extends StatelessWidget {
  const CeoOrganizationMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Organization Map',
      subtitle: 'Hierarchical tree of thousands of employees, grouped by office, role, and geography.',
      kpiCards: const [
        KPIConfig(label: 'Total Personnel', value: '8,421', trend: '+115', color: Colors.blue),
        KPIConfig(label: 'Management Ratio', value: '1:14', trend: 'Efficient', color: Colors.green),
        KPIConfig(label: 'Open Reqs', value: '342', trend: '+12', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Interactive Org Chart', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Deeply nested, searchable visual tree connecting the boardroom to individual remote clinical workers...'),
            ],
          ),
        ),
      ],
    );
  }
}

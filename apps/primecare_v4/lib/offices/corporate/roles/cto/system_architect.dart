import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CtoSystemArchitectScreen extends StatelessWidget {
  const CtoSystemArchitectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'System Architect',
      subtitle: 'View core ERDs and technical debt metrics.',
      kpiCards: const [
        KPIConfig(label: 'Tech Debt Index', value: '82/100', trend: 'Improving', color: Colors.green),
        KPIConfig(label: 'Core Services', value: '42', trend: 'Microservices', color: Colors.blue),
        KPIConfig(label: 'Outdated Deps', value: '14', trend: 'NPM/Pub', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Live ERD Graph', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Auto-generated visual map of the PrimeCare Prisma database schema and its interdependencies...'),
            ],
          ),
        ),
      ],
    );
  }
}

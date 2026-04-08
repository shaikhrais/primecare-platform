import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CeoStrategicKpisScreen extends StatelessWidget {
  const CeoStrategicKpisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Strategic KPIs',
      subtitle: 'Dashboard tracking 5-year longitudinal goals and ESG scores.',
      kpiCards: const [
        KPIConfig(label: 'Net Zero Target', value: '34%', trend: 'On Track', color: Colors.green),
        KPIConfig(label: 'Societal Impact', value: 'A+', trend: 'Stable', color: Colors.purple),
        KPIConfig(label: 'Digital Transformation', value: '82%', trend: 'Ahead', color: Colors.blue),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Long Term Objectives', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Progress tracking for massive paradigm-shifting goals...'),
            ],
          ),
        ),
      ],
    );
  }
}

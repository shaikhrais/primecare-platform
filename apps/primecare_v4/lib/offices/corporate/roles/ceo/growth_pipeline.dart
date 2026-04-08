import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CeoGrowthPipelineScreen extends StatelessWidget {
  const CeoGrowthPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Growth Pipeline',
      subtitle:
          'Strategic master board tracking potential M&A targets, new clinical service lines, and major real estate negotiations.',
      kpiCards: const [
        KPIConfig(
          label: 'Active M&A',
          value: '3',
          trend: 'In Due Diligence',
          color: Colors.purple,
        ),
        KPIConfig(
          label: 'New Service Lines',
          value: '2',
          trend: 'Piloting',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Enterprise Value',
          value: '\$2.1B',
          trend: '+15%',
          color: Colors.green,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Strategic M&A Targets',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Visual breakdown of competitive clinics under acquisition assessment...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

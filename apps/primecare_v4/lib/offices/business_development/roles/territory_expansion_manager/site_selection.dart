import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class TerritorySiteSelectionScreen extends StatelessWidget {
  const TerritorySiteSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Site Selection Criteria',
      subtitle: 'Interactive criteria checklist scoring potential retail units for clinical viability.',
      kpiCards: const [
        KPIConfig(label: 'Sites Evaluated', value: '142', trend: 'YTD', color: Colors.blue),
        KPIConfig(label: 'Avg Score', value: '88/100', trend: 'High Quality', color: Colors.green),
        KPIConfig(label: 'Rejected', value: '41', trend: 'Zoning Issues', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Viability Scorecard', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive grid scoring properties on parking availability, square footage, and proximity to competitors...'),
            ],
          ),
        ),
      ],
    );
  }
}

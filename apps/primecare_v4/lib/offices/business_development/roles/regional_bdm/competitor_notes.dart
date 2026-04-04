import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class RegionalBdmCompetitorsScreen extends StatelessWidget {
  const RegionalBdmCompetitorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Competitor Intelligence',
      subtitle: 'Market share trends, competitor notes, and strategic battlecards.',
      kpiCards: const [
        KPIConfig(label: 'Total Competitors Tracked', value: '14', trend: 'Watch', color: Colors.blue),
        KPIConfig(label: 'Local Market Share', value: '28%', trend: '+4%', color: Colors.green),
        KPIConfig(label: 'Churn to Competitor', value: '2.1%', trend: '-0.5%', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Competitor Analysis Matrix', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Side-by-side comparison of local pricing, features, and positioning...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Strategic Battlecards', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Quick reference guides to counter competitor claims in the region...'),
            ],
          ),
        ),
      ],
    );
  }
}

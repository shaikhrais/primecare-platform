import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class MarketAnalysisScreen extends StatelessWidget {
  const MarketAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Market Analysis',
      subtitle: 'Detailed view showing demographic overlays, competitor heatmaps, and target patient populations.',
      kpiCards: const [
        KPIConfig(label: 'Total Total Addressable Market', value: '4.2M', trend: 'Growing', color: Colors.blue),
        KPIConfig(label: 'Competitor Density', value: 'Med-High', trend: 'Watch', color: Colors.orange),
        KPIConfig(label: 'Optimal Locations', value: '18', trend: 'Scouted', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Demographic Overlays', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Geospatial charts indicating income levels, average age, and healthcare expenditure...'),
            ],
          ),
        ),
      ],
    );
  }
}

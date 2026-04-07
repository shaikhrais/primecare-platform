import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class SalesPipelineScreen extends StatelessWidget {
  const SalesPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Sales Pipeline Funnel',
      subtitle: 'Visualizing active sales, gaps in territories, and closed deals.',
      kpiCards: const [
        KPIConfig(label: 'Total Pipeline Value', value: '\$8.5M', trend: 'Growing', color: Colors.blue),
        KPIConfig(label: 'Territory Gaps', value: '3', trend: 'Review Required', color: Colors.orange),
        KPIConfig(label: 'Closed Deals (YTD)', value: '14', trend: '+2', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Funnel Overview', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Visual funnel showing transition from Lead formulation to Closed Won...'),
            ],
          ),
        ),
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Territory Gap Analysis', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Highlighting regions with high demand but low franchise coverage...'),
            ],
          ),
        ),
      ],
    );
  }
}

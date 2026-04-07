import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CeoFranchiseOverviewScreen extends StatelessWidget {
  const CeoFranchiseOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Franchise Overview',
      subtitle: 'Summary of total franchise revenues, top performing franchisees, and upcoming franchise launches.',
      kpiCards: const [
        KPIConfig(label: 'Total Franchises', value: '82', trend: '+4', color: Colors.blue),
        KPIConfig(label: 'Franchise Revenue', value: '\$14.2M', trend: '+3%', color: Colors.green),
        KPIConfig(label: 'Default Rate', value: '1.2%', trend: '-0.1%', color: Colors.purple),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Top Performers', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Ranked list of the highest grossing independently operated franchise locations...'),
            ],
          ),
        ),
      ],
    );
  }
}

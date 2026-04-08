import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class TerritoryExpansionPlansScreen extends StatelessWidget {
  const TerritoryExpansionPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Master Plans & Blueprints',
      subtitle: 'Detailed master plans and construction blueprints for approved sites.',
      kpiCards: const [
        KPIConfig(label: 'Blueprints', value: '42', trend: 'Approved', color: Colors.blue),
        KPIConfig(label: 'Vendor Bids', value: '8', trend: 'Pending', color: Colors.orange),
        KPIConfig(label: 'Permits', value: '100%', trend: 'Cleared', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Document Repository', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Secure staging for architectural CAD files, city bylaws, and compliance documentation...'),
            ],
          ),
        ),
      ],
    );
  }
}

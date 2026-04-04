import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class PartnerManagementScreen extends StatelessWidget {
  const PartnerManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Partner Directory',
      subtitle: 'Complete list of active partners and integration statuses.',
      kpiCards: const [
        KPIConfig(label: 'Total Active Partners', value: '56', trend: '+4', color: Colors.blue),
        KPIConfig(label: 'Tier 1 Partners', value: '12', trend: 'Exclusive', color: Colors.purple),
        KPIConfig(label: 'Pending Integrations', value: '5', trend: 'In Progress', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Partner Directory', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Searchable list showing Partner Name, Region, Tier, and Contract Status...'),
            ],
          ),
        ),
      ],
    );
  }
}

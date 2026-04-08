import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class PartnershipRenewalsScreen extends StatelessWidget {
  const PartnershipRenewalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Renewals & Upsells',
      subtitle: 'Track upcoming contract renewals, upsell opportunities, and churn risks.',
      kpiCards: const [
        KPIConfig(label: 'Renewals < 90d', value: '84', trend: 'Action Req', color: Colors.orange),
        KPIConfig(label: 'Churn Risk', value: '12%', trend: 'High Priority', color: Colors.red),
        KPIConfig(label: 'Upsell Value', value: '\$1.4M', trend: 'Projected', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Renewal Pipeline', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Sortable matrix identifying high-value accounts up for contract renewal...'),
            ],
          ),
        ),
      ],
    );
  }
}

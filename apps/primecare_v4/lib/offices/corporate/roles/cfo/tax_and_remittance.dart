import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class CfoTaxAndRemittanceScreen extends StatelessWidget {
  const CfoTaxAndRemittanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Tax & Remittance',
      subtitle: 'Tracking cross-border international taxation liabilities, payroll remittances, and quarterly corporate obligations.',
      kpiCards: const [
        KPIConfig(label: 'Total Tax Liabilities', value: '\$14.2M', trend: 'Budgeted', color: Colors.blue),
        KPIConfig(label: 'Upcoming Deadlines', value: '3', trend: '< 14 Days', color: Colors.orange),
        KPIConfig(label: 'Audit Defense', value: 'Complete', trend: 'Pass', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Global Tax Map', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive portal detailing all national, state, and provincial tax obligations and compliance tracking...'),
            ],
          ),
        ),
      ],
    );
  }
}

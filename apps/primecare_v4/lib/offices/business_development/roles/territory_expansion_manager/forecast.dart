import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class TerritoryForecastScreen extends StatelessWidget {
  const TerritoryForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Revenue Forecasting',
      subtitle: 'Projected revenue forecasts mapping physical real estate capacity increases.',
      kpiCards: const [
        KPIConfig(label: 'Capacity Add', value: '+4,200', trend: 'Patients/mo', color: Colors.blue),
        KPIConfig(label: 'Revenue Lift', value: '\$14M', trend: 'Annual', color: Colors.green),
        KPIConfig(label: 'Margin', value: '28%', trend: 'EBITDA', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Forecast Modeling', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Algorithmic modeling of future cash flows heavily reliant on the success rate of current expansions...'),
            ],
          ),
        ),
      ],
    );
  }
}

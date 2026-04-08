import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class TerritoryNewClinicsScreen extends StatelessWidget {
  const TerritoryNewClinicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'New Clinic Launches',
      subtitle:
          'Track the initial 30-day performance of recently launched clinics.',
      kpiCards: const [
        KPIConfig(
          label: 'New Openings',
          value: '8',
          trend: 'L30 Days',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Patient Volume',
          value: '1,420',
          trend: 'Actual vs Est',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Hiring Gaps',
          value: '4',
          trend: 'Priority',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Launch Post-Mortem',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Tracker measuring grand opening marketing ROI and day-1 clinical operational stability...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

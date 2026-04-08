import 'package:flutter/material.dart';
import '../../../../components/page_template.dart';
import '../../../../components/clinical_glass.dart';

class ComplianceCredentialTrackingScreen extends StatelessWidget {
  const ComplianceCredentialTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Credential Tracking',
      subtitle: 'Monitor professional license validity for doctors, nurses, and allied health staff.',
      kpiCards: const [
        KPIConfig(label: 'Total Active Staff', value: '4,210', trend: 'Verified', color: Colors.blue),
        KPIConfig(label: 'Expiring < 30 Days', value: '18', trend: 'Requires Review', color: Colors.orange),
        KPIConfig(label: 'Expired', value: '0', trend: 'Compliant', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Staff Credential Roster', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Searchable grid of all active clinical staff with automatic color-coding for imminent expiration dates...'),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class ComplianceDocumentExpiryScreen extends StatelessWidget {
  const ComplianceDocumentExpiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Facility Document Expiry',
      subtitle: 'Track organizational and facility-level certificates and licenses across the enterprise.',
      kpiCards: const [
        KPIConfig(label: 'Monitored Documents', value: '342', trend: 'Active', color: Colors.blue),
        KPIConfig(label: 'Expiring Q4', value: '12', trend: 'Action Required', color: Colors.orange),
        KPIConfig(label: 'Critical Missing', value: '0', trend: 'None', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enterprise Asset Licenses', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Monitoring view for fire safety certificates, elevator inspections, and regional operating licenses...'),
            ],
          ),
        ),
      ],
    );
  }
}

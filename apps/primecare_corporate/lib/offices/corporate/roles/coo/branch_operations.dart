import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CooBranchOperationsScreen extends StatelessWidget {
  const CooBranchOperationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Branch Operations',
      subtitle:
          'Monitor specific daily operational metrics like door-to-doctor time for outpatient clinics.',
      kpiCards: const [
        KPIConfig(
          label: 'Door-to-Doctor',
          value: '14 mins',
          trend: '-2 mins',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Throughput',
          value: '8,400',
          trend: 'Patients/Day',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Average Bed Tx',
          value: '42 mins',
          trend: 'Turnaround',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Operational Workflow',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Live operational flow charts outlining patient movement from intake to discharge...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

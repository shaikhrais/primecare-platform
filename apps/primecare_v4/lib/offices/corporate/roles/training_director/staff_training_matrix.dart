import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class StaffTrainingMatrixScreen extends StatelessWidget {
  const StaffTrainingMatrixScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Staff Training Matrix',
      subtitle: 'View cross-departmental skill gaps and upskilling progress.',
      kpiCards: const [
        KPIConfig(label: 'Total Staff', value: '12,400', trend: 'Tracked', color: Colors.blue),
        KPIConfig(label: 'Skill Gaps', value: '412', trend: 'Targeted', color: Colors.orange),
        KPIConfig(label: 'Upskill Rate', value: '+14%', trend: 'YoY Growth', color: Colors.green),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Global Skill Distribution', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Interactive matrix mapping specific clinical capabilities (e.g., PICC lines) against available nursing staff per region...'),
            ],
          ),
        ),
      ],
    );
  }
}

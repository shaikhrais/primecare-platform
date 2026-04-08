import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CtoSystemSettingsScreen extends StatelessWidget {
  const CtoSystemSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Global Settings',
      subtitle: 'Manage global environment variables and kill switches.',
      kpiCards: const [
        KPIConfig(
          label: 'Environment',
          value: 'Production',
          trend: 'Locked',
          color: Colors.green,
        ),
        KPIConfig(
          label: 'Feature Flags',
          value: '42',
          trend: 'Active',
          color: Colors.blue,
        ),
        KPIConfig(
          label: 'Kill Switches',
          value: '0',
          trend: 'Engaged',
          color: Colors.orange,
        ),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Configuration Vault',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                'Secure management of core variables, third-party API keys, and emergency maintenance toggles...',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

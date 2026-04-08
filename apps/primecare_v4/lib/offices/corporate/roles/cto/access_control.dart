import 'package:flutter/material.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';

class CtoAccessControlScreen extends StatelessWidget {
  const CtoAccessControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Access Control',
      subtitle: 'Manage multi-tenant SAML SSO configurations and 2FA policies across the clinical network.',
      kpiCards: const [
        KPIConfig(label: 'Active Users', value: '14.2k', trend: 'Online', color: Colors.blue),
        KPIConfig(label: 'Failed Logins', value: '12', trend: '< 1%', color: Colors.green),
        KPIConfig(label: 'Pending Approval', value: '42', trend: 'Accounts', color: Colors.orange),
      ],
      sections: [
        ClinicalGlass(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Identity Provider Config', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const Text('Centralized configuration dashboard for enterprise OIDC and SAML connectivity...'),
            ],
          ),
        ),
      ],
    );
  }
}

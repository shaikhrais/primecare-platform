import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cto_integrations_header_section.dart';
import 'sections/cto_integrations_content_summary_section.dart';
import 'sections/cto_integrations_primary_content_section.dart';
import 'sections/cto_integrations_action_bar_section.dart';

class CtoIntegrationsScreen extends StatelessWidget {
  const CtoIntegrationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cto_integrations',
      title: 'Cto Integrations',
      child: Column(
        children: const [
          const CtoIntegrationsHeaderSection(),
          const CtoIntegrationsContentSummarySection(),
          const CtoIntegrationsPrimaryContentSection(),
          const CtoIntegrationsActionBarSection(),
        ],
      ),
    );
  }
}

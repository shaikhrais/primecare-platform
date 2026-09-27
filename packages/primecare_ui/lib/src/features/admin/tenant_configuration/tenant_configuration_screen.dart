import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/tenant_configuration_header_section.dart';
import 'sections/tenant_configuration_content_summary_section.dart';
import 'sections/tenant_configuration_primary_content_section.dart';
import 'sections/tenant_configuration_action_bar_section.dart';

class TenantConfigurationScreen extends StatelessWidget {
  const TenantConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'tenant_configuration',
      title: 'Tenant Configuration',
      child: Column(
        children: const [
          const TenantConfigurationHeaderSection(),
          const TenantConfigurationContentSummarySection(),
          const TenantConfigurationPrimaryContentSection(),
          const TenantConfigurationActionBarSection(),
        ],
      ),
    );
  }
}

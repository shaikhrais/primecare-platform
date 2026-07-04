import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/infrastructure_compliance_header_section.dart';
import 'sections/infrastructure_compliance_content_summary_section.dart';
import 'sections/infrastructure_compliance_primary_content_section.dart';
import 'sections/infrastructure_compliance_action_bar_section.dart';

class InfrastructureComplianceScreen extends StatelessWidget {
  const InfrastructureComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'infrastructure_compliance',
      title: 'InfrastructureComplianceScreen',
      child: Column(
        children: const [
          const InfrastructureComplianceHeaderSection(),
          const InfrastructureComplianceContentSummarySection(),
          const InfrastructureCompliancePrimaryContentSection(),
          const InfrastructureComplianceActionBarSection(),
        ],
      ),
    );
  }
}

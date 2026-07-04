import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_manager_compliance_header_section.dart';
import 'sections/compliance_manager_compliance_content_summary_section.dart';
import 'sections/compliance_manager_compliance_primary_content_section.dart';
import 'sections/compliance_manager_compliance_action_bar_section.dart';

class ComplianceManagerComplianceScreen extends StatelessWidget {
  const ComplianceManagerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_manager_compliance',
      title: 'ComplianceManagerComplianceScreen',
      child: Column(
        children: const [
          const ComplianceManagerComplianceHeaderSection(),
          const ComplianceManagerComplianceContentSummarySection(),
          const ComplianceManagerCompliancePrimaryContentSection(),
          const ComplianceManagerComplianceActionBarSection(),
        ],
      ),
    );
  }
}

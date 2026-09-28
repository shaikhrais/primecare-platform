import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_manager_policies_header_section.dart';
import 'sections/compliance_manager_policies_content_summary_section.dart';
import 'sections/compliance_manager_policies_primary_content_section.dart';
import 'sections/compliance_manager_policies_action_bar_section.dart';

class ComplianceManagerPoliciesScreen extends StatelessWidget {
  const ComplianceManagerPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_manager_policies',
      title: 'Compliance Manager Policies',
      child: Column(
        children: const [
          const ComplianceManagerPoliciesHeaderSection(),
          const ComplianceManagerPoliciesContentSummarySection(),
          const ComplianceManagerPoliciesPrimaryContentSection(),
          const ComplianceManagerPoliciesActionBarSection(),
        ],
      ),
    );
  }
}

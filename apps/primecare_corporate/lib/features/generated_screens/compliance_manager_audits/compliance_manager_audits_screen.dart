import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_manager_audits_header_section.dart';
import 'sections/compliance_manager_audits_content_summary_section.dart';
import 'sections/compliance_manager_audits_primary_content_section.dart';
import 'sections/compliance_manager_audits_action_bar_section.dart';

class ComplianceManagerAuditsScreen extends StatelessWidget {
  const ComplianceManagerAuditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_manager_audits',
      title: 'Compliance Manager Audits',
      child: Column(
        children: const [
          const ComplianceManagerAuditsHeaderSection(),
          const ComplianceManagerAuditsContentSummarySection(),
          const ComplianceManagerAuditsPrimaryContentSection(),
          const ComplianceManagerAuditsActionBarSection(),
        ],
      ),
    );
  }
}

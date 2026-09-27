import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_manager_compliance_cases_header_section.dart';
import 'sections/compliance_manager_compliance_cases_content_summary_section.dart';
import 'sections/compliance_manager_compliance_cases_primary_content_section.dart';
import 'sections/compliance_manager_compliance_cases_action_bar_section.dart';

class ComplianceManagerComplianceCasesScreen extends StatelessWidget {
  const ComplianceManagerComplianceCasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_manager_compliance_cases',
      title: 'Compliance Manager Compliance Cases',
      child: Column(
        children: const [
          const ComplianceManagerComplianceCasesHeaderSection(),
          const ComplianceManagerComplianceCasesContentSummarySection(),
          const ComplianceManagerComplianceCasesPrimaryContentSection(),
          const ComplianceManagerComplianceCasesActionBarSection(),
        ],
      ),
    );
  }
}

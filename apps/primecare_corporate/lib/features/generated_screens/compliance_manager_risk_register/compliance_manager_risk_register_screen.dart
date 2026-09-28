import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_manager_risk_register_header_section.dart';
import 'sections/compliance_manager_risk_register_content_summary_section.dart';
import 'sections/compliance_manager_risk_register_primary_content_section.dart';
import 'sections/compliance_manager_risk_register_action_bar_section.dart';

class ComplianceManagerRiskRegisterScreen extends StatelessWidget {
  const ComplianceManagerRiskRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_manager_risk_register',
      title: 'Compliance Manager Risk Register',
      child: Column(
        children: const [
          const ComplianceManagerRiskRegisterHeaderSection(),
          const ComplianceManagerRiskRegisterContentSummarySection(),
          const ComplianceManagerRiskRegisterPrimaryContentSection(),
          const ComplianceManagerRiskRegisterActionBarSection(),
        ],
      ),
    );
  }
}

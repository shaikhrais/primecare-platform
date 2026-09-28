import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/compliance_manager_training_compliance_header_section.dart';
import 'sections/compliance_manager_training_compliance_content_summary_section.dart';
import 'sections/compliance_manager_training_compliance_primary_content_section.dart';
import 'sections/compliance_manager_training_compliance_action_bar_section.dart';

class ComplianceManagerTrainingComplianceScreen extends StatelessWidget {
  const ComplianceManagerTrainingComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'compliance_manager_training_compliance',
      title: 'Compliance Manager Training Compliance',
      child: Column(
        children: const [
          const ComplianceManagerTrainingComplianceHeaderSection(),
          const ComplianceManagerTrainingComplianceContentSummarySection(),
          const ComplianceManagerTrainingCompliancePrimaryContentSection(),
          const ComplianceManagerTrainingComplianceActionBarSection(),
        ],
      ),
    );
  }
}

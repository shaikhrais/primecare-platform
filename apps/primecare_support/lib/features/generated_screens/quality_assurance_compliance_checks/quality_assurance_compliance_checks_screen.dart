import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/quality_assurance_compliance_checks_header_section.dart';
import 'sections/quality_assurance_compliance_checks_content_summary_section.dart';
import 'sections/quality_assurance_compliance_checks_primary_content_section.dart';
import 'sections/quality_assurance_compliance_checks_action_bar_section.dart';

class QualityAssuranceComplianceChecksScreen extends StatelessWidget {
  const QualityAssuranceComplianceChecksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'quality_assurance_compliance_checks',
      title: 'Quality Assurance Compliance Checks',
      child: Column(
        children: const [
          const QualityAssuranceComplianceChecksHeaderSection(),
          const QualityAssuranceComplianceChecksContentSummarySection(),
          const QualityAssuranceComplianceChecksPrimaryContentSection(),
          const QualityAssuranceComplianceChecksActionBarSection(),
        ],
      ),
    );
  }
}

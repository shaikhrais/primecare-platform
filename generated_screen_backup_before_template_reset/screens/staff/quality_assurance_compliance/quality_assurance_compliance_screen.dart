import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/quality_assurance_compliance_header_section.dart';
import 'sections/quality_assurance_compliance_content_summary_section.dart';
import 'sections/quality_assurance_compliance_primary_content_section.dart';
import 'sections/quality_assurance_compliance_action_bar_section.dart';

class QualityAssuranceComplianceScreen extends StatelessWidget {
  const QualityAssuranceComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'quality_assurance_compliance',
      title: 'QualityAssuranceComplianceScreen',
      child: Column(
        children: const [
          const QualityAssuranceComplianceHeaderSection(),
          const QualityAssuranceComplianceContentSummarySection(),
          const QualityAssuranceCompliancePrimaryContentSection(),
          const QualityAssuranceComplianceActionBarSection(),
        ],
      ),
    );
  }
}

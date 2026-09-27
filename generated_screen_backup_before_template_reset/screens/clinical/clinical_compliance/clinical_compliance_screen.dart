import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_compliance_header_section.dart';
import 'sections/clinical_compliance_content_summary_section.dart';
import 'sections/clinical_compliance_primary_content_section.dart';
import 'sections/clinical_compliance_action_bar_section.dart';

class ClinicalComplianceScreen extends StatelessWidget {
  const ClinicalComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_compliance',
      title: 'ClinicalComplianceScreen',
      child: Column(
        children: const [
          const ClinicalComplianceHeaderSection(),
          const ClinicalComplianceContentSummarySection(),
          const ClinicalCompliancePrimaryContentSection(),
          const ClinicalComplianceActionBarSection(),
        ],
      ),
    );
  }
}

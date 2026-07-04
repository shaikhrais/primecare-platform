import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_director_compliance_header_section.dart';
import 'sections/clinical_director_compliance_content_summary_section.dart';
import 'sections/clinical_director_compliance_primary_content_section.dart';
import 'sections/clinical_director_compliance_action_bar_section.dart';

class ClinicalDirectorComplianceScreen extends StatelessWidget {
  const ClinicalDirectorComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_director_compliance',
      title: 'ClinicalDirectorComplianceScreen',
      child: Column(
        children: const [
          const ClinicalDirectorComplianceHeaderSection(),
          const ClinicalDirectorComplianceContentSummarySection(),
          const ClinicalDirectorCompliancePrimaryContentSection(),
          const ClinicalDirectorComplianceActionBarSection(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_director_staffing_header_section.dart';
import 'sections/clinical_director_staffing_content_summary_section.dart';
import 'sections/clinical_director_staffing_primary_content_section.dart';
import 'sections/clinical_director_staffing_action_bar_section.dart';

class ClinicalDirectorStaffingScreen extends StatelessWidget {
  const ClinicalDirectorStaffingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_director_staffing',
      title: 'Clinical Director Staffing',
      child: Column(
        children: const [
          const ClinicalDirectorStaffingHeaderSection(),
          const ClinicalDirectorStaffingContentSummarySection(),
          const ClinicalDirectorStaffingPrimaryContentSection(),
          const ClinicalDirectorStaffingActionBarSection(),
        ],
      ),
    );
  }
}

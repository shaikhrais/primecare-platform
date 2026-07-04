import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_hiring_applicants_header_section.dart';
import 'sections/hr_hiring_applicants_content_summary_section.dart';
import 'sections/hr_hiring_applicants_primary_content_section.dart';
import 'sections/hr_hiring_applicants_action_bar_section.dart';

class HrHiringApplicantsScreen extends StatelessWidget {
  const HrHiringApplicantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_hiring_applicants',
      title: 'HrHiringApplicantsScreen',
      child: Column(
        children: const [
          const HrHiringApplicantsHeaderSection(),
          const HrHiringApplicantsContentSummarySection(),
          const HrHiringApplicantsPrimaryContentSection(),
          const HrHiringApplicantsActionBarSection(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_applicants_header_section.dart';
import 'sections/hr_applicants_content_summary_section.dart';
import 'sections/hr_applicants_primary_content_section.dart';
import 'sections/hr_applicants_action_bar_section.dart';

class HrApplicantsScreen extends StatelessWidget {
  const HrApplicantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_applicants',
      title: 'Hr Applicants',
      child: Column(
        children: const [
          const HrApplicantsHeaderSection(),
          const HrApplicantsContentSummarySection(),
          const HrApplicantsPrimaryContentSection(),
          const HrApplicantsActionBarSection(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/chiropractic_assessment_header_section.dart';
import 'sections/chiropractic_assessment_content_summary_section.dart';
import 'sections/chiropractic_assessment_primary_content_section.dart';
import 'sections/chiropractic_assessment_action_bar_section.dart';

class ChiropracticAssessmentScreen extends StatelessWidget {
  const ChiropracticAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'chiropractic_assessment',
      title: 'ChiropracticAssessmentScreen',
      child: Column(
        children: const [
          const ChiropracticAssessmentHeaderSection(),
          const ChiropracticAssessmentContentSummarySection(),
          const ChiropracticAssessmentPrimaryContentSection(),
          const ChiropracticAssessmentActionBarSection(),
        ],
      ),
    );
  }
}

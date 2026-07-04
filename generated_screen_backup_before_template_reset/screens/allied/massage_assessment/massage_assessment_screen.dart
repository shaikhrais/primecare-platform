import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/massage_assessment_header_section.dart';
import 'sections/massage_assessment_content_summary_section.dart';
import 'sections/massage_assessment_primary_content_section.dart';
import 'sections/massage_assessment_action_bar_section.dart';

class MassageAssessmentScreen extends StatelessWidget {
  const MassageAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'massage_assessment',
      title: 'MassageAssessmentScreen',
      child: Column(
        children: const [
          const MassageAssessmentHeaderSection(),
          const MassageAssessmentContentSummarySection(),
          const MassageAssessmentPrimaryContentSection(),
          const MassageAssessmentActionBarSection(),
        ],
      ),
    );
  }
}

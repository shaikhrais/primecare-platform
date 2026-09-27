import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rmt_assessment_header_section.dart';
import 'sections/rmt_assessment_content_summary_section.dart';
import 'sections/rmt_assessment_primary_content_section.dart';
import 'sections/rmt_assessment_action_bar_section.dart';

class RmtAssessmentScreen extends StatelessWidget {
  const RmtAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rmt_assessment',
      title: 'RmtAssessmentScreen',
      child: Column(
        children: const [
          const RmtAssessmentHeaderSection(),
          const RmtAssessmentContentSummarySection(),
          const RmtAssessmentPrimaryContentSection(),
          const RmtAssessmentActionBarSection(),
        ],
      ),
    );
  }
}

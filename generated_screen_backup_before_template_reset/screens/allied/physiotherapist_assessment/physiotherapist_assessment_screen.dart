import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/physiotherapist_assessment_header_section.dart';
import 'sections/physiotherapist_assessment_content_summary_section.dart';
import 'sections/physiotherapist_assessment_primary_content_section.dart';
import 'sections/physiotherapist_assessment_action_bar_section.dart';

class PhysiotherapistAssessmentScreen extends StatelessWidget {
  const PhysiotherapistAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'physiotherapist_assessment',
      title: 'PhysiotherapistAssessmentScreen',
      child: Column(
        children: const [
          const PhysiotherapistAssessmentHeaderSection(),
          const PhysiotherapistAssessmentContentSummarySection(),
          const PhysiotherapistAssessmentPrimaryContentSection(),
          const PhysiotherapistAssessmentActionBarSection(),
        ],
      ),
    );
  }
}

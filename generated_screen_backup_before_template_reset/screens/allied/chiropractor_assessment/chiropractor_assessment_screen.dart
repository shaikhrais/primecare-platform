import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/chiropractor_assessment_header_section.dart';
import 'sections/chiropractor_assessment_content_summary_section.dart';
import 'sections/chiropractor_assessment_primary_content_section.dart';
import 'sections/chiropractor_assessment_action_bar_section.dart';

class ChiropractorAssessmentScreen extends StatelessWidget {
  const ChiropractorAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'chiropractor_assessment',
      title: 'ChiropractorAssessmentScreen',
      child: Column(
        children: const [
          const ChiropractorAssessmentHeaderSection(),
          const ChiropractorAssessmentContentSummarySection(),
          const ChiropractorAssessmentPrimaryContentSection(),
          const ChiropractorAssessmentActionBarSection(),
        ],
      ),
    );
  }
}

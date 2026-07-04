import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_assessments_header_section.dart';
import 'sections/rn_assessments_content_summary_section.dart';
import 'sections/rn_assessments_primary_content_section.dart';
import 'sections/rn_assessments_action_bar_section.dart';

class RnAssessmentsScreen extends StatelessWidget {
  const RnAssessmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_assessments',
      title: 'RnAssessmentsScreen',
      child: Column(
        children: const [
          const RnAssessmentsHeaderSection(),
          const RnAssessmentsContentSummarySection(),
          const RnAssessmentsPrimaryContentSection(),
          const RnAssessmentsActionBarSection(),
        ],
      ),
    );
  }
}

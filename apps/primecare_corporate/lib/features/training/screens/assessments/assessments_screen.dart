import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/assessments_header_section.dart';
import 'sections/assessments_content_summary_section.dart';
import 'sections/assessments_primary_content_section.dart';
import 'sections/assessments_action_bar_section.dart';

class AssessmentsScreen extends StatelessWidget {
  const AssessmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'assessments',
      title: 'Assessments',
      child: Column(
        children: const [
          const AssessmentsHeaderSection(),
          const AssessmentsContentSummarySection(),
          const AssessmentsPrimaryContentSection(),
          const AssessmentsActionBarSection(),
        ],
      ),
    );
  }
}

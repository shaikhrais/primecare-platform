import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_coordinator_assessments_header_section.dart';
import 'sections/intake_coordinator_assessments_content_summary_section.dart';
import 'sections/intake_coordinator_assessments_primary_content_section.dart';
import 'sections/intake_coordinator_assessments_action_bar_section.dart';

class IntakeCoordinatorAssessmentsScreen extends StatelessWidget {
  const IntakeCoordinatorAssessmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_coordinator_assessments',
      title: 'Intake Coordinator Assessments',
      child: Column(
        children: const [
          const IntakeCoordinatorAssessmentsHeaderSection(),
          const IntakeCoordinatorAssessmentsContentSummarySection(),
          const IntakeCoordinatorAssessmentsPrimaryContentSection(),
          const IntakeCoordinatorAssessmentsActionBarSection(),
        ],
      ),
    );
  }
}

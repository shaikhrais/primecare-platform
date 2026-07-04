import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_coordinator_assessment_queue_header_section.dart';
import 'sections/intake_coordinator_assessment_queue_content_summary_section.dart';
import 'sections/intake_coordinator_assessment_queue_primary_content_section.dart';
import 'sections/intake_coordinator_assessment_queue_action_bar_section.dart';

class IntakeCoordinatorAssessmentQueueScreen extends StatelessWidget {
  const IntakeCoordinatorAssessmentQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_coordinator_assessment_queue',
      title: 'IntakeCoordinatorAssessmentQueueScreen',
      child: Column(
        children: const [
          const IntakeCoordinatorAssessmentQueueHeaderSection(),
          const IntakeCoordinatorAssessmentQueueContentSummarySection(),
          const IntakeCoordinatorAssessmentQueuePrimaryContentSection(),
          const IntakeCoordinatorAssessmentQueueActionBarSection(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_coordinator_scheduling_header_section.dart';
import 'sections/intake_coordinator_scheduling_content_summary_section.dart';
import 'sections/intake_coordinator_scheduling_primary_content_section.dart';
import 'sections/intake_coordinator_scheduling_action_bar_section.dart';

class IntakeCoordinatorSchedulingScreen extends StatelessWidget {
  const IntakeCoordinatorSchedulingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_coordinator_scheduling',
      title: 'Intake Coordinator Scheduling',
      child: Column(
        children: const [
          const IntakeCoordinatorSchedulingHeaderSection(),
          const IntakeCoordinatorSchedulingContentSummarySection(),
          const IntakeCoordinatorSchedulingPrimaryContentSection(),
          const IntakeCoordinatorSchedulingActionBarSection(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_coordinator_client_assignment_header_section.dart';
import 'sections/intake_coordinator_client_assignment_content_summary_section.dart';
import 'sections/intake_coordinator_client_assignment_primary_content_section.dart';
import 'sections/intake_coordinator_client_assignment_action_bar_section.dart';

class IntakeCoordinatorClientAssignmentScreen extends StatelessWidget {
  const IntakeCoordinatorClientAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_coordinator_client_assignment',
      title: 'Intake Coordinator Client Assignment',
      child: Column(
        children: const [
          const IntakeCoordinatorClientAssignmentHeaderSection(),
          const IntakeCoordinatorClientAssignmentContentSummarySection(),
          const IntakeCoordinatorClientAssignmentPrimaryContentSection(),
          const IntakeCoordinatorClientAssignmentActionBarSection(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/therapist_workflow_header_section.dart';
import 'sections/therapist_workflow_task_filters_section.dart';
import 'sections/therapist_workflow_task_list_section.dart';
import 'sections/therapist_workflow_task_details_section.dart';
import 'sections/therapist_workflow_action_bar_section.dart';

class TherapistWorkflowScreen extends StatelessWidget {
  const TherapistWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'therapist_workflow',
      title: 'Therapist Compliance Workflow',
      child: Column(
        children: const [
          const TherapistWorkflowHeaderSection(),
          const TherapistWorkflowTaskFiltersSection(),
          const TherapistWorkflowTaskListSection(),
          const TherapistWorkflowTaskDetailsSection(),
          const TherapistWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

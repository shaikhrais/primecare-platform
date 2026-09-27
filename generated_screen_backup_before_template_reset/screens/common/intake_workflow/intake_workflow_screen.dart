import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/intake_workflow_header_section.dart';
import 'sections/intake_workflow_task_filters_section.dart';
import 'sections/intake_workflow_task_list_section.dart';
import 'sections/intake_workflow_task_details_section.dart';
import 'sections/intake_workflow_action_bar_section.dart';

class IntakeWorkflowScreen extends StatelessWidget {
  const IntakeWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'intake_workflow',
      title: 'IntakeWorkflowScreen',
      child: Column(
        children: const [
          const IntakeWorkflowHeaderSection(),
          const IntakeWorkflowTaskFiltersSection(),
          const IntakeWorkflowTaskListSection(),
          const IntakeWorkflowTaskDetailsSection(),
          const IntakeWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

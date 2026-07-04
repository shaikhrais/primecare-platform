import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_hiring_workflow_header_section.dart';
import 'sections/hr_hiring_workflow_task_filters_section.dart';
import 'sections/hr_hiring_workflow_task_list_section.dart';
import 'sections/hr_hiring_workflow_task_details_section.dart';
import 'sections/hr_hiring_workflow_action_bar_section.dart';

class HrHiringWorkflowScreen extends StatelessWidget {
  const HrHiringWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_hiring_workflow',
      title: 'HrHiringWorkflowScreen',
      child: Column(
        children: const [
          const HrHiringWorkflowHeaderSection(),
          const HrHiringWorkflowTaskFiltersSection(),
          const HrHiringWorkflowTaskListSection(),
          const HrHiringWorkflowTaskDetailsSection(),
          const HrHiringWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

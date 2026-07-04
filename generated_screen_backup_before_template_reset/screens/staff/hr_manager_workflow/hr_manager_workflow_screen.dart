import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_manager_workflow_header_section.dart';
import 'sections/hr_manager_workflow_task_filters_section.dart';
import 'sections/hr_manager_workflow_task_list_section.dart';
import 'sections/hr_manager_workflow_task_details_section.dart';
import 'sections/hr_manager_workflow_action_bar_section.dart';

class HrManagerWorkflowScreen extends StatelessWidget {
  const HrManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_manager_workflow',
      title: 'HrManagerWorkflowScreen',
      child: Column(
        children: const [
          const HrManagerWorkflowHeaderSection(),
          const HrManagerWorkflowTaskFiltersSection(),
          const HrManagerWorkflowTaskListSection(),
          const HrManagerWorkflowTaskDetailsSection(),
          const HrManagerWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

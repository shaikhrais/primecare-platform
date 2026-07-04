import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hr_director_workflow_header_section.dart';
import 'sections/hr_director_workflow_task_filters_section.dart';
import 'sections/hr_director_workflow_task_list_section.dart';
import 'sections/hr_director_workflow_task_details_section.dart';
import 'sections/hr_director_workflow_action_bar_section.dart';

class HrDirectorWorkflowScreen extends StatelessWidget {
  const HrDirectorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hr_director_workflow',
      title: 'HrDirectorWorkflowScreen',
      child: Column(
        children: const [
          const HrDirectorWorkflowHeaderSection(),
          const HrDirectorWorkflowTaskFiltersSection(),
          const HrDirectorWorkflowTaskListSection(),
          const HrDirectorWorkflowTaskDetailsSection(),
          const HrDirectorWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

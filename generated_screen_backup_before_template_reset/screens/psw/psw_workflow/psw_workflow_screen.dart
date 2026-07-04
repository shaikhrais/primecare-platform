import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_workflow_header_section.dart';
import 'sections/psw_workflow_task_filters_section.dart';
import 'sections/psw_workflow_task_list_section.dart';
import 'sections/psw_workflow_task_details_section.dart';
import 'sections/psw_workflow_action_bar_section.dart';

class PswWorkflowScreen extends StatelessWidget {
  const PswWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_workflow',
      title: 'Psw Workflow',
      child: Column(
        children: const [
          const PswWorkflowHeaderSection(),
          const PswWorkflowTaskFiltersSection(),
          const PswWorkflowTaskListSection(),
          const PswWorkflowTaskDetailsSection(),
          const PswWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

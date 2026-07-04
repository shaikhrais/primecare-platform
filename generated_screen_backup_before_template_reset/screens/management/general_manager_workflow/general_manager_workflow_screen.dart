import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/general_manager_workflow_header_section.dart';
import 'sections/general_manager_workflow_task_filters_section.dart';
import 'sections/general_manager_workflow_task_list_section.dart';
import 'sections/general_manager_workflow_task_details_section.dart';
import 'sections/general_manager_workflow_action_bar_section.dart';

class GeneralManagerWorkflowScreen extends StatelessWidget {
  const GeneralManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'general_manager_workflow',
      title: 'GeneralManagerWorkflowScreen',
      child: Column(
        children: const [
          const GeneralManagerWorkflowHeaderSection(),
          const GeneralManagerWorkflowTaskFiltersSection(),
          const GeneralManagerWorkflowTaskListSection(),
          const GeneralManagerWorkflowTaskDetailsSection(),
          const GeneralManagerWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

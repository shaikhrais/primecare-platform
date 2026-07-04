import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cx_director_workflow_header_section.dart';
import 'sections/cx_director_workflow_task_filters_section.dart';
import 'sections/cx_director_workflow_task_list_section.dart';
import 'sections/cx_director_workflow_task_details_section.dart';
import 'sections/cx_director_workflow_action_bar_section.dart';

class CxDirectorWorkflowScreen extends StatelessWidget {
  const CxDirectorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cx_director_workflow',
      title: 'CxDirectorWorkflowScreen',
      child: Column(
        children: const [
          const CxDirectorWorkflowHeaderSection(),
          const CxDirectorWorkflowTaskFiltersSection(),
          const CxDirectorWorkflowTaskListSection(),
          const CxDirectorWorkflowTaskDetailsSection(),
          const CxDirectorWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

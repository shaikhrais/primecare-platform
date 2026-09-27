import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cto_workflow_header_section.dart';
import 'sections/cto_workflow_task_filters_section.dart';
import 'sections/cto_workflow_task_list_section.dart';
import 'sections/cto_workflow_task_details_section.dart';
import 'sections/cto_workflow_action_bar_section.dart';

class CtoWorkflowScreen extends StatelessWidget {
  const CtoWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cto_workflow',
      title: 'CtoWorkflowScreen',
      child: Column(
        children: const [
          const CtoWorkflowHeaderSection(),
          const CtoWorkflowTaskFiltersSection(),
          const CtoWorkflowTaskListSection(),
          const CtoWorkflowTaskDetailsSection(),
          const CtoWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

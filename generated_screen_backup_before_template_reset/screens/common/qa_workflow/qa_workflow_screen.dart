import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/qa_workflow_header_section.dart';
import 'sections/qa_workflow_task_filters_section.dart';
import 'sections/qa_workflow_task_list_section.dart';
import 'sections/qa_workflow_task_details_section.dart';
import 'sections/qa_workflow_action_bar_section.dart';

class QaWorkflowScreen extends StatelessWidget {
  const QaWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'qa_workflow',
      title: 'QaWorkflowScreen',
      child: Column(
        children: const [
          const QaWorkflowHeaderSection(),
          const QaWorkflowTaskFiltersSection(),
          const QaWorkflowTaskListSection(),
          const QaWorkflowTaskDetailsSection(),
          const QaWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

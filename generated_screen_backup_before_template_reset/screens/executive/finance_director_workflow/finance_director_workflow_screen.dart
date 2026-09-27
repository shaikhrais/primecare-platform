import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/finance_director_workflow_header_section.dart';
import 'sections/finance_director_workflow_task_filters_section.dart';
import 'sections/finance_director_workflow_task_list_section.dart';
import 'sections/finance_director_workflow_task_details_section.dart';
import 'sections/finance_director_workflow_action_bar_section.dart';

class FinanceDirectorWorkflowScreen extends StatelessWidget {
  const FinanceDirectorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'finance_director_workflow',
      title: 'FinanceDirectorWorkflowScreen',
      child: Column(
        children: const [
          const FinanceDirectorWorkflowHeaderSection(),
          const FinanceDirectorWorkflowTaskFiltersSection(),
          const FinanceDirectorWorkflowTaskListSection(),
          const FinanceDirectorWorkflowTaskDetailsSection(),
          const FinanceDirectorWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coo_workflow_header_section.dart';
import 'sections/coo_workflow_task_filters_section.dart';
import 'sections/coo_workflow_task_list_section.dart';
import 'sections/coo_workflow_task_details_section.dart';
import 'sections/coo_workflow_action_bar_section.dart';

class CooWorkflowScreen extends StatelessWidget {
  const CooWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coo_workflow',
      title: 'CooWorkflowScreen',
      child: Column(
        children: const [
          const CooWorkflowHeaderSection(),
          const CooWorkflowTaskFiltersSection(),
          const CooWorkflowTaskListSection(),
          const CooWorkflowTaskDetailsSection(),
          const CooWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

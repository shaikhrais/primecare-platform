import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/office_workflow_header_section.dart';
import 'sections/office_workflow_task_filters_section.dart';
import 'sections/office_workflow_task_list_section.dart';
import 'sections/office_workflow_task_details_section.dart';
import 'sections/office_workflow_action_bar_section.dart';

class OfficeWorkflowScreen extends StatelessWidget {
  const OfficeWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'office_workflow',
      title: 'OfficeWorkflowScreen',
      child: Column(
        children: const [
          const OfficeWorkflowHeaderSection(),
          const OfficeWorkflowTaskFiltersSection(),
          const OfficeWorkflowTaskListSection(),
          const OfficeWorkflowTaskDetailsSection(),
          const OfficeWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

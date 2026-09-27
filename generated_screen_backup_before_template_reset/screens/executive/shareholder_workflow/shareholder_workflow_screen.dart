import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/shareholder_workflow_header_section.dart';
import 'sections/shareholder_workflow_task_filters_section.dart';
import 'sections/shareholder_workflow_task_list_section.dart';
import 'sections/shareholder_workflow_task_details_section.dart';
import 'sections/shareholder_workflow_action_bar_section.dart';

class ShareholderWorkflowScreen extends StatelessWidget {
  const ShareholderWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'shareholder_workflow',
      title: 'ShareholderWorkflowScreen',
      child: Column(
        children: const [
          const ShareholderWorkflowHeaderSection(),
          const ShareholderWorkflowTaskFiltersSection(),
          const ShareholderWorkflowTaskListSection(),
          const ShareholderWorkflowTaskDetailsSection(),
          const ShareholderWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

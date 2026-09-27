import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/owner_workflow_header_section.dart';
import 'sections/owner_workflow_task_filters_section.dart';
import 'sections/owner_workflow_task_list_section.dart';
import 'sections/owner_workflow_task_details_section.dart';
import 'sections/owner_workflow_action_bar_section.dart';

class OwnerWorkflowScreen extends StatelessWidget {
  const OwnerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'owner_workflow',
      title: 'OwnerWorkflowScreen',
      child: Column(
        children: const [
          const OwnerWorkflowHeaderSection(),
          const OwnerWorkflowTaskFiltersSection(),
          const OwnerWorkflowTaskListSection(),
          const OwnerWorkflowTaskDetailsSection(),
          const OwnerWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

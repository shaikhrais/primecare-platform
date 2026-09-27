import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_workflow_header_section.dart';
import 'sections/franchise_workflow_task_filters_section.dart';
import 'sections/franchise_workflow_task_list_section.dart';
import 'sections/franchise_workflow_task_details_section.dart';
import 'sections/franchise_workflow_action_bar_section.dart';

class FranchiseWorkflowScreen extends StatelessWidget {
  const FranchiseWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_workflow',
      title: 'FranchiseWorkflowScreen',
      child: Column(
        children: const [
          const FranchiseWorkflowHeaderSection(),
          const FranchiseWorkflowTaskFiltersSection(),
          const FranchiseWorkflowTaskListSection(),
          const FranchiseWorkflowTaskDetailsSection(),
          const FranchiseWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

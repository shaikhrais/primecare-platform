import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_sales_manager_workflow_header_section.dart';
import 'sections/franchise_sales_manager_workflow_task_filters_section.dart';
import 'sections/franchise_sales_manager_workflow_task_list_section.dart';
import 'sections/franchise_sales_manager_workflow_task_details_section.dart';
import 'sections/franchise_sales_manager_workflow_action_bar_section.dart';

class FranchiseSalesManagerWorkflowScreen extends StatelessWidget {
  const FranchiseSalesManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_sales_manager_workflow',
      title: 'FranchiseSalesManagerWorkflowScreen',
      child: Column(
        children: const [
          const FranchiseSalesManagerWorkflowHeaderSection(),
          const FranchiseSalesManagerWorkflowTaskFiltersSection(),
          const FranchiseSalesManagerWorkflowTaskListSection(),
          const FranchiseSalesManagerWorkflowTaskDetailsSection(),
          const FranchiseSalesManagerWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

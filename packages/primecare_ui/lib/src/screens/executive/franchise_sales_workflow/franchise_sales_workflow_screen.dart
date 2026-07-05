import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_sales_workflow_header_section.dart';
import 'sections/franchise_sales_workflow_task_filters_section.dart';
import 'sections/franchise_sales_workflow_task_list_section.dart';
import 'sections/franchise_sales_workflow_task_details_section.dart';
import 'sections/franchise_sales_workflow_action_bar_section.dart';

class FranchiseSalesWorkflowScreen extends StatelessWidget {
  const FranchiseSalesWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_sales_workflow',
      title: 'Franchise Sales Manager Compliance Workflow',
      child: Column(
        children: const [
          const FranchiseSalesWorkflowHeaderSection(),
          const FranchiseSalesWorkflowTaskFiltersSection(),
          const FranchiseSalesWorkflowTaskListSection(),
          const FranchiseSalesWorkflowTaskDetailsSection(),
          const FranchiseSalesWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

typedef FranchiseSalesManagerComplianceWorkflowScreen = FranchiseSalesWorkflowScreen;

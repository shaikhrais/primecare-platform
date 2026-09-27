import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/billing_admin_workflow_header_section.dart';
import 'sections/billing_admin_workflow_task_filters_section.dart';
import 'sections/billing_admin_workflow_task_list_section.dart';
import 'sections/billing_admin_workflow_task_details_section.dart';
import 'sections/billing_admin_workflow_action_bar_section.dart';

class BillingAdminWorkflowScreen extends StatelessWidget {
  const BillingAdminWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'billing_admin_workflow',
      title: 'BillingAdminWorkflowScreen',
      child: Column(
        children: const [
          const BillingAdminWorkflowHeaderSection(),
          const BillingAdminWorkflowTaskFiltersSection(),
          const BillingAdminWorkflowTaskListSection(),
          const BillingAdminWorkflowTaskDetailsSection(),
          const BillingAdminWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

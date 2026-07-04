import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/customer_support_workflow_header_section.dart';
import 'sections/customer_support_workflow_task_filters_section.dart';
import 'sections/customer_support_workflow_task_list_section.dart';
import 'sections/customer_support_workflow_task_details_section.dart';
import 'sections/customer_support_workflow_action_bar_section.dart';

class CustomerSupportWorkflowScreen extends StatelessWidget {
  const CustomerSupportWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'customer_support_workflow',
      title: 'CustomerSupportWorkflowScreen',
      child: Column(
        children: const [
          const CustomerSupportWorkflowHeaderSection(),
          const CustomerSupportWorkflowTaskFiltersSection(),
          const CustomerSupportWorkflowTaskListSection(),
          const CustomerSupportWorkflowTaskDetailsSection(),
          const CustomerSupportWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

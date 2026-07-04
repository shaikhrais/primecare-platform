import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/head_of_marketing_workflow_header_section.dart';
import 'sections/head_of_marketing_workflow_task_filters_section.dart';
import 'sections/head_of_marketing_workflow_task_list_section.dart';
import 'sections/head_of_marketing_workflow_task_details_section.dart';
import 'sections/head_of_marketing_workflow_action_bar_section.dart';

class HeadOfMarketingWorkflowScreen extends StatelessWidget {
  const HeadOfMarketingWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'head_of_marketing_workflow',
      title: 'HeadOfMarketingWorkflowScreen',
      child: Column(
        children: const [
          const HeadOfMarketingWorkflowHeaderSection(),
          const HeadOfMarketingWorkflowTaskFiltersSection(),
          const HeadOfMarketingWorkflowTaskListSection(),
          const HeadOfMarketingWorkflowTaskDetailsSection(),
          const HeadOfMarketingWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

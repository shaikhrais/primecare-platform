import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/business_development_workflow_header_section.dart';
import 'sections/business_development_workflow_task_filters_section.dart';
import 'sections/business_development_workflow_task_list_section.dart';
import 'sections/business_development_workflow_task_details_section.dart';
import 'sections/business_development_workflow_action_bar_section.dart';

class BusinessDevelopmentWorkflowScreen extends StatelessWidget {
  const BusinessDevelopmentWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'business_development_workflow',
      title: 'BusinessDevelopmentWorkflowScreen',
      child: Column(
        children: const [
          const BusinessDevelopmentWorkflowHeaderSection(),
          const BusinessDevelopmentWorkflowTaskFiltersSection(),
          const BusinessDevelopmentWorkflowTaskListSection(),
          const BusinessDevelopmentWorkflowTaskDetailsSection(),
          const BusinessDevelopmentWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

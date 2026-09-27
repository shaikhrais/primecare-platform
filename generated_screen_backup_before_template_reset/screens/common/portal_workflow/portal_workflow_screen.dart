import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/portal_workflow_header_section.dart';
import 'sections/portal_workflow_task_filters_section.dart';
import 'sections/portal_workflow_task_list_section.dart';
import 'sections/portal_workflow_task_details_section.dart';
import 'sections/portal_workflow_action_bar_section.dart';

class PortalWorkflowScreen extends StatelessWidget {
  const PortalWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'portal_workflow',
      title: 'PortalWorkflowScreen',
      child: Column(
        children: const [
          const PortalWorkflowHeaderSection(),
          const PortalWorkflowTaskFiltersSection(),
          const PortalWorkflowTaskListSection(),
          const PortalWorkflowTaskDetailsSection(),
          const PortalWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

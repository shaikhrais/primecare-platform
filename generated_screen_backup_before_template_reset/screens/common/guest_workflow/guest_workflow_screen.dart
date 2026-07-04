import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/guest_workflow_header_section.dart';
import 'sections/guest_workflow_task_filters_section.dart';
import 'sections/guest_workflow_task_list_section.dart';
import 'sections/guest_workflow_task_details_section.dart';
import 'sections/guest_workflow_action_bar_section.dart';

class GuestWorkflowScreen extends StatelessWidget {
  const GuestWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'guest_workflow',
      title: 'GuestWorkflowScreen',
      child: Column(
        children: const [
          const GuestWorkflowHeaderSection(),
          const GuestWorkflowTaskFiltersSection(),
          const GuestWorkflowTaskListSection(),
          const GuestWorkflowTaskDetailsSection(),
          const GuestWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

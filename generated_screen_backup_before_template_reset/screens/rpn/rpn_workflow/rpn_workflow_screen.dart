import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rpn_workflow_header_section.dart';
import 'sections/rpn_workflow_task_filters_section.dart';
import 'sections/rpn_workflow_task_list_section.dart';
import 'sections/rpn_workflow_task_details_section.dart';
import 'sections/rpn_workflow_action_bar_section.dart';

class RpnWorkflowScreen extends StatelessWidget {
  const RpnWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rpn_workflow',
      title: 'RpnWorkflowScreen',
      child: Column(
        children: const [
          const RpnWorkflowHeaderSection(),
          const RpnWorkflowTaskFiltersSection(),
          const RpnWorkflowTaskListSection(),
          const RpnWorkflowTaskDetailsSection(),
          const RpnWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

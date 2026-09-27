import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/physiotherapist_workflow_header_section.dart';
import 'sections/physiotherapist_workflow_task_filters_section.dart';
import 'sections/physiotherapist_workflow_task_list_section.dart';
import 'sections/physiotherapist_workflow_task_details_section.dart';
import 'sections/physiotherapist_workflow_action_bar_section.dart';

class PhysiotherapistWorkflowScreen extends StatelessWidget {
  const PhysiotherapistWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'physiotherapist_workflow',
      title: 'PhysiotherapistWorkflowScreen',
      child: Column(
        children: const [
          const PhysiotherapistWorkflowHeaderSection(),
          const PhysiotherapistWorkflowTaskFiltersSection(),
          const PhysiotherapistWorkflowTaskListSection(),
          const PhysiotherapistWorkflowTaskDetailsSection(),
          const PhysiotherapistWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

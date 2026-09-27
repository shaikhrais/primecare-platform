import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/regional_bdm_workflow_header_section.dart';
import 'sections/regional_bdm_workflow_task_filters_section.dart';
import 'sections/regional_bdm_workflow_task_list_section.dart';
import 'sections/regional_bdm_workflow_task_details_section.dart';
import 'sections/regional_bdm_workflow_action_bar_section.dart';

class RegionalBdmWorkflowScreen extends StatelessWidget {
  const RegionalBdmWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'regional_bdm_workflow',
      title: 'RegionalBdmWorkflowScreen',
      child: Column(
        children: const [
          const RegionalBdmWorkflowHeaderSection(),
          const RegionalBdmWorkflowTaskFiltersSection(),
          const RegionalBdmWorkflowTaskListSection(),
          const RegionalBdmWorkflowTaskDetailsSection(),
          const RegionalBdmWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

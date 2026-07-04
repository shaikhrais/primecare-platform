import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/partnership_manager_workflow_header_section.dart';
import 'sections/partnership_manager_workflow_task_filters_section.dart';
import 'sections/partnership_manager_workflow_task_list_section.dart';
import 'sections/partnership_manager_workflow_task_details_section.dart';
import 'sections/partnership_manager_workflow_action_bar_section.dart';

class PartnershipManagerWorkflowScreen extends StatelessWidget {
  const PartnershipManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'partnership_manager_workflow',
      title: 'PartnershipManagerWorkflowScreen',
      child: Column(
        children: const [
          const PartnershipManagerWorkflowHeaderSection(),
          const PartnershipManagerWorkflowTaskFiltersSection(),
          const PartnershipManagerWorkflowTaskListSection(),
          const PartnershipManagerWorkflowTaskDetailsSection(),
          const PartnershipManagerWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

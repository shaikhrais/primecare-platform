import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/vip_manager_workflow_header_section.dart';
import 'sections/vip_manager_workflow_task_filters_section.dart';
import 'sections/vip_manager_workflow_task_list_section.dart';
import 'sections/vip_manager_workflow_task_details_section.dart';
import 'sections/vip_manager_workflow_action_bar_section.dart';

class VipManagerWorkflowScreen extends StatelessWidget {
  const VipManagerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'vip_manager_workflow',
      title: 'VIP Client Manager Compliance Workflow',
      child: Column(
        children: const [
          const VipManagerWorkflowHeaderSection(),
          const VipManagerWorkflowTaskFiltersSection(),
          const VipManagerWorkflowTaskListSection(),
          const VipManagerWorkflowTaskDetailsSection(),
          const VipManagerWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

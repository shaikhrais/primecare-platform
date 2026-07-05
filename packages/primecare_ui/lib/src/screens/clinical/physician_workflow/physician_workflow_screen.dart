import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/physician_workflow_header_section.dart';
import 'sections/physician_workflow_task_filters_section.dart';
import 'sections/physician_workflow_task_list_section.dart';
import 'sections/physician_workflow_task_details_section.dart';
import 'sections/physician_workflow_action_bar_section.dart';

class PhysicianWorkflowScreen extends StatelessWidget {
  const PhysicianWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'physician_workflow',
      title: 'Physician Compliance Workflow',
      child: Column(
        children: const [
          const PhysicianWorkflowHeaderSection(),
          const PhysicianWorkflowTaskFiltersSection(),
          const PhysicianWorkflowTaskListSection(),
          const PhysicianWorkflowTaskDetailsSection(),
          const PhysicianWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

typedef PhysicianComplianceWorkflowScreen = PhysicianWorkflowScreen;

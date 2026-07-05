import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/pediatric_workflow_header_section.dart';
import 'sections/pediatric_workflow_task_filters_section.dart';
import 'sections/pediatric_workflow_task_list_section.dart';
import 'sections/pediatric_workflow_task_details_section.dart';
import 'sections/pediatric_workflow_action_bar_section.dart';

class PediatricWorkflowScreen extends StatelessWidget {
  const PediatricWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'pediatric_workflow',
      title: 'Pediatric Specialist Compliance Workflow',
      child: Column(
        children: const [
          const PediatricWorkflowHeaderSection(),
          const PediatricWorkflowTaskFiltersSection(),
          const PediatricWorkflowTaskListSection(),
          const PediatricWorkflowTaskDetailsSection(),
          const PediatricWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

typedef PediatricSpecialistComplianceWorkflowScreen = PediatricWorkflowScreen;

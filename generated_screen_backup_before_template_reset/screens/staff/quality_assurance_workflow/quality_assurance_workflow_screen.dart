import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/quality_assurance_workflow_header_section.dart';
import 'sections/quality_assurance_workflow_task_filters_section.dart';
import 'sections/quality_assurance_workflow_task_list_section.dart';
import 'sections/quality_assurance_workflow_task_details_section.dart';
import 'sections/quality_assurance_workflow_action_bar_section.dart';

class QualityAssuranceWorkflowScreen extends StatelessWidget {
  const QualityAssuranceWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'quality_assurance_workflow',
      title: 'QualityAssuranceWorkflowScreen',
      child: Column(
        children: const [
          const QualityAssuranceWorkflowHeaderSection(),
          const QualityAssuranceWorkflowTaskFiltersSection(),
          const QualityAssuranceWorkflowTaskListSection(),
          const QualityAssuranceWorkflowTaskDetailsSection(),
          const QualityAssuranceWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

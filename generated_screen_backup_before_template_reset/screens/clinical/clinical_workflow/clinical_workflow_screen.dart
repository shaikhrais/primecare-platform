import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinical_workflow_header_section.dart';
import 'sections/clinical_workflow_task_filters_section.dart';
import 'sections/clinical_workflow_task_list_section.dart';
import 'sections/clinical_workflow_task_details_section.dart';
import 'sections/clinical_workflow_action_bar_section.dart';

class ClinicalWorkflowScreen extends StatelessWidget {
  const ClinicalWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinical_workflow',
      title: 'ClinicalWorkflowScreen',
      child: Column(
        children: const [
          const ClinicalWorkflowHeaderSection(),
          const ClinicalWorkflowTaskFiltersSection(),
          const ClinicalWorkflowTaskListSection(),
          const ClinicalWorkflowTaskDetailsSection(),
          const ClinicalWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

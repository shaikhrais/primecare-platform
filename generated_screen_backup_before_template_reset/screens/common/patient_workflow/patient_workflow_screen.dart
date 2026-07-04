import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_workflow_header_section.dart';
import 'sections/patient_workflow_task_filters_section.dart';
import 'sections/patient_workflow_task_list_section.dart';
import 'sections/patient_workflow_task_details_section.dart';
import 'sections/patient_workflow_action_bar_section.dart';

class PatientWorkflowScreen extends StatelessWidget {
  const PatientWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_workflow',
      title: 'PatientWorkflowScreen',
      child: Column(
        children: const [
          const PatientWorkflowHeaderSection(),
          const PatientWorkflowTaskFiltersSection(),
          const PatientWorkflowTaskListSection(),
          const PatientWorkflowTaskDetailsSection(),
          const PatientWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

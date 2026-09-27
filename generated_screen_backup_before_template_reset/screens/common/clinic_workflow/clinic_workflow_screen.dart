import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinic_workflow_header_section.dart';
import 'sections/clinic_workflow_task_filters_section.dart';
import 'sections/clinic_workflow_task_list_section.dart';
import 'sections/clinic_workflow_task_details_section.dart';
import 'sections/clinic_workflow_action_bar_section.dart';

class ClinicWorkflowScreen extends StatelessWidget {
  const ClinicWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinic_workflow',
      title: 'ClinicWorkflowScreen',
      child: Column(
        children: const [
          const ClinicWorkflowHeaderSection(),
          const ClinicWorkflowTaskFiltersSection(),
          const ClinicWorkflowTaskListSection(),
          const ClinicWorkflowTaskDetailsSection(),
          const ClinicWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

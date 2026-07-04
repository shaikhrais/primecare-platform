import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/employee_workflow_header_section.dart';
import 'sections/employee_workflow_task_filters_section.dart';
import 'sections/employee_workflow_task_list_section.dart';
import 'sections/employee_workflow_task_details_section.dart';
import 'sections/employee_workflow_action_bar_section.dart';

class EmployeeWorkflowScreen extends StatelessWidget {
  const EmployeeWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'employee_workflow',
      title: 'Employee Compliance Workflow',
      child: Column(
        children: const [
          const EmployeeWorkflowHeaderSection(),
          const EmployeeWorkflowTaskFiltersSection(),
          const EmployeeWorkflowTaskListSection(),
          const EmployeeWorkflowTaskDetailsSection(),
          const EmployeeWorkflowActionBarSection(),
        ],
      ),
    );
  }
}

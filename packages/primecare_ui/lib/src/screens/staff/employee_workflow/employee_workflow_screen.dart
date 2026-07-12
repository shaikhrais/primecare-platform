import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'employee_workflow_screen_controller.dart';
import 'sections/employee_workflow_header_section.dart';
import 'sections/employee_workflow_task_filters_section.dart';
import 'sections/employee_workflow_task_list_section.dart';
import 'sections/employee_workflow_task_details_section.dart';
import 'sections/employee_workflow_action_bar_section.dart';


class EmployeeComplianceWorkflowScreen extends ConsumerWidget {
  const EmployeeComplianceWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(employee_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Employee Compliance Workflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(employee_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('employee_workflow_loading'), child: Semantics(label: 'employee_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('employee_workflow_screen'),
                    child: Column(
                      children: [
                        EmployeeWorkflowHeaderSection(data: state.data),
                        EmployeeWorkflowTaskFiltersSection(data: state.data),
                        EmployeeWorkflowTaskListSection(data: state.data),
                        EmployeeWorkflowTaskDetailsSection(data: state.data),
                        EmployeeWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

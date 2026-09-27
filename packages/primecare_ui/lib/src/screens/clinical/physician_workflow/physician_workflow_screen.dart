import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'physician_workflow_screen_controller.dart';
import 'sections/physician_workflow_header_section.dart';
import 'sections/physician_workflow_task_filters_section.dart';
import 'sections/physician_workflow_task_list_section.dart';
import 'sections/physician_workflow_task_details_section.dart';
import 'sections/physician_workflow_action_bar_section.dart';


class PhysicianComplianceWorkflowScreen extends ConsumerWidget {
  const PhysicianComplianceWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(physician_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Physician Compliance Workflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(physician_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('physician_workflow_loading'), child: Semantics(label: 'physician_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('physician_workflow_screen'),
                    child: Column(
                      children: [
                        PhysicianWorkflowHeaderSection(data: state.data),
                        PhysicianWorkflowTaskFiltersSection(data: state.data),
                        PhysicianWorkflowTaskListSection(data: state.data),
                        PhysicianWorkflowTaskDetailsSection(data: state.data),
                        PhysicianWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

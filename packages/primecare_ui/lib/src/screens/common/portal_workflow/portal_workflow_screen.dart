import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'portal_workflow_screen_controller.dart';
import 'sections/portal_workflow_header_section.dart';
import 'sections/portal_workflow_task_filters_section.dart';
import 'sections/portal_workflow_task_list_section.dart';
import 'sections/portal_workflow_task_details_section.dart';
import 'sections/portal_workflow_action_bar_section.dart';


class PortalWorkflowScreen extends ConsumerWidget {
  const PortalWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(portal_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PortalWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(portal_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('portal_workflow_loading'), child: Semantics(label: 'portal_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('portal_workflow_screen'),
                    child: Column(
                      children: [
                        PortalWorkflowHeaderSection(data: state.data),
                        PortalWorkflowTaskFiltersSection(data: state.data),
                        PortalWorkflowTaskListSection(data: state.data),
                        PortalWorkflowTaskDetailsSection(data: state.data),
                        PortalWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

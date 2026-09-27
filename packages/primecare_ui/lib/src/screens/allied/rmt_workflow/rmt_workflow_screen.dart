import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rmt_workflow_screen_controller.dart';
import 'sections/rmt_workflow_header_section.dart';
import 'sections/rmt_workflow_task_filters_section.dart';
import 'sections/rmt_workflow_task_list_section.dart';
import 'sections/rmt_workflow_task_details_section.dart';
import 'sections/rmt_workflow_action_bar_section.dart';


class RmtWorkflowScreen extends ConsumerWidget {
  const RmtWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rmt_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RmtWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rmt_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rmt_workflow_loading'), child: Semantics(label: 'rmt_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rmt_workflow_screen'),
                    child: Column(
                      children: [
                        RmtWorkflowHeaderSection(data: state.data),
                        RmtWorkflowTaskFiltersSection(data: state.data),
                        RmtWorkflowTaskListSection(data: state.data),
                        RmtWorkflowTaskDetailsSection(data: state.data),
                        RmtWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

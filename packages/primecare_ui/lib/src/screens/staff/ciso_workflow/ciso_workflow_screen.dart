import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'ciso_workflow_screen_controller.dart';
import 'sections/ciso_workflow_header_section.dart';
import 'sections/ciso_workflow_task_filters_section.dart';
import 'sections/ciso_workflow_task_list_section.dart';
import 'sections/ciso_workflow_task_details_section.dart';
import 'sections/ciso_workflow_action_bar_section.dart';


class CisoWorkflowScreen extends ConsumerWidget {
  const CisoWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ciso_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CisoWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(ciso_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('ciso_workflow_loading'), child: Semantics(label: 'ciso_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('ciso_workflow_screen'),
                    child: Column(
                      children: [
                        CisoWorkflowHeaderSection(data: state.data),
                        CisoWorkflowTaskFiltersSection(data: state.data),
                        CisoWorkflowTaskListSection(data: state.data),
                        CisoWorkflowTaskDetailsSection(data: state.data),
                        CisoWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

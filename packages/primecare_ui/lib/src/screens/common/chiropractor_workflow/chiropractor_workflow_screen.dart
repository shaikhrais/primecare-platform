import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'chiropractor_workflow_screen_controller.dart';
import 'sections/chiropractor_workflow_header_section.dart';
import 'sections/chiropractor_workflow_task_filters_section.dart';
import 'sections/chiropractor_workflow_task_list_section.dart';
import 'sections/chiropractor_workflow_task_details_section.dart';
import 'sections/chiropractor_workflow_action_bar_section.dart';


class ChiropractorWorkflowScreen extends ConsumerWidget {
  const ChiropractorWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chiropractor_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ChiropractorWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(chiropractor_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('chiropractor_workflow_loading'), child: Semantics(label: 'chiropractor_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('chiropractor_workflow_screen'),
                    child: Column(
                      children: [
                        ChiropractorWorkflowHeaderSection(data: state.data),
                        ChiropractorWorkflowTaskFiltersSection(data: state.data),
                        ChiropractorWorkflowTaskListSection(data: state.data),
                        ChiropractorWorkflowTaskDetailsSection(data: state.data),
                        ChiropractorWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

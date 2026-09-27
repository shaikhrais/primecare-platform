import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'business_development_workflow_screen_controller.dart';
import 'sections/business_development_workflow_header_section.dart';
import 'sections/business_development_workflow_task_filters_section.dart';
import 'sections/business_development_workflow_task_list_section.dart';
import 'sections/business_development_workflow_task_details_section.dart';
import 'sections/business_development_workflow_action_bar_section.dart';


class BusinessDevelopmentWorkflowScreen extends ConsumerWidget {
  const BusinessDevelopmentWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(business_development_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('BusinessDevelopmentWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(business_development_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('business_development_workflow_loading'), child: Semantics(label: 'business_development_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('business_development_workflow_screen'),
                    child: Column(
                      children: [
                        BusinessDevelopmentWorkflowHeaderSection(data: state.data),
                        BusinessDevelopmentWorkflowTaskFiltersSection(data: state.data),
                        BusinessDevelopmentWorkflowTaskListSection(data: state.data),
                        BusinessDevelopmentWorkflowTaskDetailsSection(data: state.data),
                        BusinessDevelopmentWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

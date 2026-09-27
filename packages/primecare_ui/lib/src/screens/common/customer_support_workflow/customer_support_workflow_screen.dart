import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'customer_support_workflow_screen_controller.dart';
import 'sections/customer_support_workflow_header_section.dart';
import 'sections/customer_support_workflow_task_filters_section.dart';
import 'sections/customer_support_workflow_task_list_section.dart';
import 'sections/customer_support_workflow_task_details_section.dart';
import 'sections/customer_support_workflow_action_bar_section.dart';


class CustomerSupportWorkflowScreen extends ConsumerWidget {
  const CustomerSupportWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(customer_support_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CustomerSupportWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(customer_support_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('customer_support_workflow_loading'), child: Semantics(label: 'customer_support_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('customer_support_workflow_screen'),
                    child: Column(
                      children: [
                        CustomerSupportWorkflowHeaderSection(data: state.data),
                        CustomerSupportWorkflowTaskFiltersSection(data: state.data),
                        CustomerSupportWorkflowTaskListSection(data: state.data),
                        CustomerSupportWorkflowTaskDetailsSection(data: state.data),
                        CustomerSupportWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

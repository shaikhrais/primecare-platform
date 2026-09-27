import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'billing_admin_workflow_screen_controller.dart';
import 'sections/billing_admin_workflow_header_section.dart';
import 'sections/billing_admin_workflow_task_filters_section.dart';
import 'sections/billing_admin_workflow_task_list_section.dart';
import 'sections/billing_admin_workflow_task_details_section.dart';
import 'sections/billing_admin_workflow_action_bar_section.dart';


class BillingAdminWorkflowScreen extends ConsumerWidget {
  const BillingAdminWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(billing_admin_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('BillingAdminWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(billing_admin_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('billing_admin_workflow_loading'), child: Semantics(label: 'billing_admin_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('billing_admin_workflow_screen'),
                    child: Column(
                      children: [
                        BillingAdminWorkflowHeaderSection(data: state.data),
                        BillingAdminWorkflowTaskFiltersSection(data: state.data),
                        BillingAdminWorkflowTaskListSection(data: state.data),
                        BillingAdminWorkflowTaskDetailsSection(data: state.data),
                        BillingAdminWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'scheduler_workflow_screen_controller.dart';
import 'sections/scheduler_workflow_header_section.dart';
import 'sections/scheduler_workflow_calendar_controls_section.dart';
import 'sections/scheduler_workflow_schedule_list_section.dart';
import 'sections/scheduler_workflow_appointment_details_section.dart';
import 'sections/scheduler_workflow_action_bar_section.dart';


class SchedulerWorkflowScreen extends ConsumerWidget {
  const SchedulerWorkflowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduler_workflowControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SchedulerWorkflow'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(scheduler_workflowControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('scheduler_workflow_loading'), child: Semantics(label: 'scheduler_workflow_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('scheduler_workflow_screen'),
                    child: Column(
                      children: [
                        SchedulerWorkflowHeaderSection(data: state.data),
                        SchedulerWorkflowCalendarControlsSection(data: state.data),
                        SchedulerWorkflowScheduleListSection(data: state.data),
                        SchedulerWorkflowAppointmentDetailsSection(data: state.data),
                        SchedulerWorkflowActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

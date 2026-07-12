import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'scheduler_conflicts_screen_controller.dart';
import 'sections/scheduler_conflicts_header_section.dart';
import 'sections/scheduler_conflicts_calendar_controls_section.dart';
import 'sections/scheduler_conflicts_schedule_list_section.dart';
import 'sections/scheduler_conflicts_appointment_details_section.dart';
import 'sections/scheduler_conflicts_action_bar_section.dart';


class SchedulerConflictsScreen extends ConsumerWidget {
  const SchedulerConflictsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduler_conflictsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SchedulerConflicts'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(scheduler_conflictsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('scheduler_conflicts_loading'), child: Semantics(label: 'scheduler_conflicts_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('scheduler_conflicts_screen'),
                    child: Column(
                      children: [
                        SchedulerConflictsHeaderSection(data: state.data),
                        SchedulerConflictsCalendarControlsSection(data: state.data),
                        SchedulerConflictsScheduleListSection(data: state.data),
                        SchedulerConflictsAppointmentDetailsSection(data: state.data),
                        SchedulerConflictsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

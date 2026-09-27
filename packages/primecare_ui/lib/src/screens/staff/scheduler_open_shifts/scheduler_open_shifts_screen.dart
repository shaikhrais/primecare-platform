import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'scheduler_open_shifts_screen_controller.dart';
import 'sections/scheduler_open_shifts_header_section.dart';
import 'sections/scheduler_open_shifts_calendar_controls_section.dart';
import 'sections/scheduler_open_shifts_schedule_list_section.dart';
import 'sections/scheduler_open_shifts_appointment_details_section.dart';
import 'sections/scheduler_open_shifts_action_bar_section.dart';


class SchedulerOpenShiftsScreen extends ConsumerWidget {
  const SchedulerOpenShiftsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduler_open_shiftsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SchedulerOpenShifts'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(scheduler_open_shiftsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('scheduler_open_shifts_loading'), child: Semantics(label: 'scheduler_open_shifts_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('scheduler_open_shifts_screen'),
                    child: Column(
                      children: [
                        SchedulerOpenShiftsHeaderSection(data: state.data),
                        SchedulerOpenShiftsCalendarControlsSection(data: state.data),
                        SchedulerOpenShiftsScheduleListSection(data: state.data),
                        SchedulerOpenShiftsAppointmentDetailsSection(data: state.data),
                        SchedulerOpenShiftsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

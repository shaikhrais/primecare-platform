import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'scheduler_calendar_screen_controller.dart';
import 'sections/scheduler_calendar_header_section.dart';
import 'sections/scheduler_calendar_calendar_controls_section.dart';
import 'sections/scheduler_calendar_schedule_list_section.dart';
import 'sections/scheduler_calendar_appointment_details_section.dart';
import 'sections/scheduler_calendar_action_bar_section.dart';


class SchedulerCalendarScreen extends ConsumerWidget {
  const SchedulerCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduler_calendarControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SchedulerCalendar'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(scheduler_calendarControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('scheduler_calendar_loading'), child: Semantics(label: 'scheduler_calendar_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('scheduler_calendar_screen'),
                    child: Column(
                      children: [
                        SchedulerCalendarHeaderSection(data: state.data),
                        SchedulerCalendarCalendarControlsSection(data: state.data),
                        SchedulerCalendarScheduleListSection(data: state.data),
                        SchedulerCalendarAppointmentDetailsSection(data: state.data),
                        SchedulerCalendarActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

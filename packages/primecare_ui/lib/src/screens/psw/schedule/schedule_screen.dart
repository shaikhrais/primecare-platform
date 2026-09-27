import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'schedule_screen_controller.dart';
import 'sections/schedule_header_section.dart';
import 'sections/schedule_calendar_controls_section.dart';
import 'sections/schedule_schedule_list_section.dart';
import 'sections/schedule_appointment_details_section.dart';
import 'sections/schedule_action_bar_section.dart';


class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduleControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Schedule'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(scheduleControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('schedule_loading'), child: Semantics(label: 'schedule_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('schedule_screen'),
                    child: Column(
                      children: [
                        ScheduleHeaderSection(data: state.data),
                        ScheduleCalendarControlsSection(data: state.data),
                        ScheduleScheduleListSection(data: state.data),
                        ScheduleAppointmentDetailsSection(data: state.data),
                        ScheduleActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

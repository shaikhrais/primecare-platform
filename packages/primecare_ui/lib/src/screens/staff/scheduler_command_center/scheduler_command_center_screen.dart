import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'scheduler_command_center_screen_controller.dart';
import 'sections/scheduler_command_center_header_section.dart';
import 'sections/scheduler_command_center_calendar_controls_section.dart';
import 'sections/scheduler_command_center_schedule_list_section.dart';
import 'sections/scheduler_command_center_appointment_details_section.dart';
import 'sections/scheduler_command_center_action_bar_section.dart';


class SchedulerCommandCenterScreen extends ConsumerWidget {
  const SchedulerCommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduler_command_centerControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SchedulerCommandCenter'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(scheduler_command_centerControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('scheduler_command_center_loading'), child: Semantics(label: 'scheduler_command_center_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('scheduler_command_center_screen'),
                    child: Column(
                      children: [
                        SchedulerCommandCenterHeaderSection(data: state.data),
                        SchedulerCommandCenterCalendarControlsSection(data: state.data),
                        SchedulerCommandCenterScheduleListSection(data: state.data),
                        SchedulerCommandCenterAppointmentDetailsSection(data: state.data),
                        SchedulerCommandCenterActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

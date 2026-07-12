import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hsw_schedule_screen_controller.dart';
import 'sections/hsw_schedule_header_section.dart';
import 'sections/hsw_schedule_calendar_controls_section.dart';
import 'sections/hsw_schedule_schedule_list_section.dart';
import 'sections/hsw_schedule_appointment_details_section.dart';
import 'sections/hsw_schedule_action_bar_section.dart';


class HswScheduleScreen extends ConsumerWidget {
  const HswScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hsw_scheduleControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HswSchedule'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hsw_scheduleControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hsw_schedule_loading'), child: Semantics(label: 'hsw_schedule_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hsw_schedule_screen'),
                    child: Column(
                      children: [
                        HswScheduleHeaderSection(data: state.data),
                        HswScheduleCalendarControlsSection(data: state.data),
                        HswScheduleScheduleListSection(data: state.data),
                        HswScheduleAppointmentDetailsSection(data: state.data),
                        HswScheduleActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

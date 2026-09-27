import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'caregiver_schedule_screen_controller.dart';
import 'sections/caregiver_schedule_header_section.dart';
import 'sections/caregiver_schedule_calendar_controls_section.dart';
import 'sections/caregiver_schedule_schedule_list_section.dart';
import 'sections/caregiver_schedule_appointment_details_section.dart';
import 'sections/caregiver_schedule_action_bar_section.dart';


class CaregiverScheduleScreen extends ConsumerWidget {
  const CaregiverScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(caregiver_scheduleControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CaregiverSchedule'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(caregiver_scheduleControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('caregiver_schedule_loading'), child: Semantics(label: 'caregiver_schedule_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('caregiver_schedule_screen'),
                    child: Column(
                      children: [
                        CaregiverScheduleHeaderSection(data: state.data),
                        CaregiverScheduleCalendarControlsSection(data: state.data),
                        CaregiverScheduleScheduleListSection(data: state.data),
                        CaregiverScheduleAppointmentDetailsSection(data: state.data),
                        CaregiverScheduleActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'calendar_management_screen_controller.dart';
import 'sections/calendar_management_header_section.dart';
import 'sections/calendar_management_calendar_controls_section.dart';
import 'sections/calendar_management_schedule_list_section.dart';
import 'sections/calendar_management_appointment_details_section.dart';
import 'sections/calendar_management_action_bar_section.dart';


class CalendarManagementScreen extends ConsumerWidget {
  const CalendarManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calendar_managementControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CalendarManagement'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(calendar_managementControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('calendar_management_loading'), child: Semantics(label: 'calendar_management_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('calendar_management_screen'),
                    child: Column(
                      children: [
                        CalendarManagementHeaderSection(data: state.data),
                        CalendarManagementCalendarControlsSection(data: state.data),
                        CalendarManagementScheduleListSection(data: state.data),
                        CalendarManagementAppointmentDetailsSection(data: state.data),
                        CalendarManagementActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

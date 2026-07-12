import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'appointment_overview_screen_controller.dart';
import 'sections/appointment_overview_header_section.dart';
import 'sections/appointment_overview_calendar_controls_section.dart';
import 'sections/appointment_overview_schedule_list_section.dart';
import 'sections/appointment_overview_appointment_details_section.dart';
import 'sections/appointment_overview_action_bar_section.dart';


class AppointmentOverviewScreen extends ConsumerWidget {
  const AppointmentOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appointment_overviewControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('AppointmentOverview'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(appointment_overviewControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('appointment_overview_loading'), child: Semantics(label: 'appointment_overview_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('appointment_overview_screen'),
                    child: Column(
                      children: [
                        AppointmentOverviewHeaderSection(data: state.data),
                        AppointmentOverviewCalendarControlsSection(data: state.data),
                        AppointmentOverviewScheduleListSection(data: state.data),
                        AppointmentOverviewAppointmentDetailsSection(data: state.data),
                        AppointmentOverviewActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

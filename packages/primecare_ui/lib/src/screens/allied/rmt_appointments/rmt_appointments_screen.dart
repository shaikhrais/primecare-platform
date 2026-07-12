import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rmt_appointments_screen_controller.dart';
import 'sections/rmt_appointments_header_section.dart';
import 'sections/rmt_appointments_calendar_controls_section.dart';
import 'sections/rmt_appointments_schedule_list_section.dart';
import 'sections/rmt_appointments_appointment_details_section.dart';
import 'sections/rmt_appointments_action_bar_section.dart';


class RmtAppointmentsScreen extends ConsumerWidget {
  const RmtAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rmt_appointmentsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RmtAppointments'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rmt_appointmentsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rmt_appointments_loading'), child: Semantics(label: 'rmt_appointments_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rmt_appointments_screen'),
                    child: Column(
                      children: [
                        RmtAppointmentsHeaderSection(data: state.data),
                        RmtAppointmentsCalendarControlsSection(data: state.data),
                        RmtAppointmentsScheduleListSection(data: state.data),
                        RmtAppointmentsAppointmentDetailsSection(data: state.data),
                        RmtAppointmentsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

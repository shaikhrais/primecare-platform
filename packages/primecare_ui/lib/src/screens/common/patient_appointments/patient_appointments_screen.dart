import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'patient_appointments_screen_controller.dart';
import 'sections/patient_appointments_header_section.dart';
import 'sections/patient_appointments_calendar_controls_section.dart';
import 'sections/patient_appointments_schedule_list_section.dart';
import 'sections/patient_appointments_appointment_details_section.dart';
import 'sections/patient_appointments_action_bar_section.dart';


class PatientAppointmentsScreen extends ConsumerWidget {
  const PatientAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patient_appointmentsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PatientAppointments'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(patient_appointmentsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('patient_appointments_loading'), child: Semantics(label: 'patient_appointments_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('patient_appointments_screen'),
                    child: Column(
                      children: [
                        PatientAppointmentsHeaderSection(data: state.data),
                        PatientAppointmentsCalendarControlsSection(data: state.data),
                        PatientAppointmentsScheduleListSection(data: state.data),
                        PatientAppointmentsAppointmentDetailsSection(data: state.data),
                        PatientAppointmentsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

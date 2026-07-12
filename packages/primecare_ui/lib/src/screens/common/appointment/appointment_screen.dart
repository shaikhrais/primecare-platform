import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'appointment_screen_controller.dart';
import 'sections/appointment_header_section.dart';
import 'sections/appointment_calendar_controls_section.dart';
import 'sections/appointment_schedule_list_section.dart';
import 'sections/appointment_appointment_details_section.dart';
import 'sections/appointment_action_bar_section.dart';


class AppointmentScreen extends ConsumerWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appointmentControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Appointment'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(appointmentControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('appointment_loading'), child: Semantics(label: 'appointment_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('appointment_screen'),
                    child: Column(
                      children: [
                        AppointmentHeaderSection(data: state.data),
                        AppointmentCalendarControlsSection(data: state.data),
                        AppointmentScheduleListSection(data: state.data),
                        AppointmentAppointmentDetailsSection(data: state.data),
                        AppointmentActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

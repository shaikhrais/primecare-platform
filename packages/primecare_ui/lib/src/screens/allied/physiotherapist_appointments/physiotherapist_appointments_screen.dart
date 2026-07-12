import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'physiotherapist_appointments_screen_controller.dart';
import 'sections/physiotherapist_appointments_header_section.dart';
import 'sections/physiotherapist_appointments_calendar_controls_section.dart';
import 'sections/physiotherapist_appointments_schedule_list_section.dart';
import 'sections/physiotherapist_appointments_appointment_details_section.dart';
import 'sections/physiotherapist_appointments_action_bar_section.dart';


class PhysiotherapistAppointmentsScreen extends ConsumerWidget {
  const PhysiotherapistAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(physiotherapist_appointmentsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PhysiotherapistAppointments'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(physiotherapist_appointmentsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('physiotherapist_appointments_loading'), child: Semantics(label: 'physiotherapist_appointments_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('physiotherapist_appointments_screen'),
                    child: Column(
                      children: [
                        PhysiotherapistAppointmentsHeaderSection(data: state.data),
                        PhysiotherapistAppointmentsCalendarControlsSection(data: state.data),
                        PhysiotherapistAppointmentsScheduleListSection(data: state.data),
                        PhysiotherapistAppointmentsAppointmentDetailsSection(data: state.data),
                        PhysiotherapistAppointmentsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'chiropractor_appointments_screen_controller.dart';
import 'sections/chiropractor_appointments_header_section.dart';
import 'sections/chiropractor_appointments_calendar_controls_section.dart';
import 'sections/chiropractor_appointments_schedule_list_section.dart';
import 'sections/chiropractor_appointments_appointment_details_section.dart';
import 'sections/chiropractor_appointments_action_bar_section.dart';


class ChiropractorAppointmentsScreen extends ConsumerWidget {
  const ChiropractorAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chiropractor_appointmentsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ChiropractorAppointments'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(chiropractor_appointmentsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('chiropractor_appointments_loading'), child: Semantics(label: 'chiropractor_appointments_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('chiropractor_appointments_screen'),
                    child: Column(
                      children: [
                        ChiropractorAppointmentsHeaderSection(data: state.data),
                        ChiropractorAppointmentsCalendarControlsSection(data: state.data),
                        ChiropractorAppointmentsScheduleListSection(data: state.data),
                        ChiropractorAppointmentsAppointmentDetailsSection(data: state.data),
                        ChiropractorAppointmentsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

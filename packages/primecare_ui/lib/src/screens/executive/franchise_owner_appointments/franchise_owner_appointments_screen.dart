import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'franchise_owner_appointments_screen_controller.dart';
import 'sections/franchise_owner_appointments_header_section.dart';
import 'sections/franchise_owner_appointments_calendar_controls_section.dart';
import 'sections/franchise_owner_appointments_schedule_list_section.dart';
import 'sections/franchise_owner_appointments_appointment_details_section.dart';
import 'sections/franchise_owner_appointments_action_bar_section.dart';


class FranchiseOwnerAppointmentsScreen extends ConsumerWidget {
  const FranchiseOwnerAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(franchise_owner_appointmentsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FranchiseOwnerAppointments'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(franchise_owner_appointmentsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('franchise_owner_appointments_loading'), child: Semantics(label: 'franchise_owner_appointments_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('franchise_owner_appointments_screen'),
                    child: Column(
                      children: [
                        FranchiseOwnerAppointmentsHeaderSection(data: state.data),
                        FranchiseOwnerAppointmentsCalendarControlsSection(data: state.data),
                        FranchiseOwnerAppointmentsScheduleListSection(data: state.data),
                        FranchiseOwnerAppointmentsAppointmentDetailsSection(data: state.data),
                        FranchiseOwnerAppointmentsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

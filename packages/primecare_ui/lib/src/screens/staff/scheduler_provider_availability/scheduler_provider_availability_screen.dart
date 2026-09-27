import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'scheduler_provider_availability_screen_controller.dart';
import 'sections/scheduler_provider_availability_header_section.dart';
import 'sections/scheduler_provider_availability_calendar_controls_section.dart';
import 'sections/scheduler_provider_availability_schedule_list_section.dart';
import 'sections/scheduler_provider_availability_appointment_details_section.dart';
import 'sections/scheduler_provider_availability_action_bar_section.dart';


class SchedulerProviderAvailabilityScreen extends ConsumerWidget {
  const SchedulerProviderAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduler_provider_availabilityControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SchedulerProviderAvailability'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(scheduler_provider_availabilityControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('scheduler_provider_availability_loading'), child: Semantics(label: 'scheduler_provider_availability_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('scheduler_provider_availability_screen'),
                    child: Column(
                      children: [
                        SchedulerProviderAvailabilityHeaderSection(data: state.data),
                        SchedulerProviderAvailabilityCalendarControlsSection(data: state.data),
                        SchedulerProviderAvailabilityScheduleListSection(data: state.data),
                        SchedulerProviderAvailabilityAppointmentDetailsSection(data: state.data),
                        SchedulerProviderAvailabilityActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

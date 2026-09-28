import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_coordinator_provider_availability_header_section.dart';
import 'sections/scheduler_coordinator_provider_availability_calendar_controls_section.dart';
import 'sections/scheduler_coordinator_provider_availability_schedule_list_section.dart';
import 'sections/scheduler_coordinator_provider_availability_appointment_details_section.dart';
import 'sections/scheduler_coordinator_provider_availability_action_bar_section.dart';

class SchedulerCoordinatorProviderAvailabilityScreen extends StatelessWidget {
  const SchedulerCoordinatorProviderAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_coordinator_provider_availability',
      title: 'Scheduler Coordinator Provider Availability',
      child: Column(
        children: const [
          const SchedulerCoordinatorProviderAvailabilityHeaderSection(),
          const SchedulerCoordinatorProviderAvailabilityCalendarControlsSection(),
          const SchedulerCoordinatorProviderAvailabilityScheduleListSection(),
          const SchedulerCoordinatorProviderAvailabilityAppointmentDetailsSection(),
          const SchedulerCoordinatorProviderAvailabilityActionBarSection(),
        ],
      ),
    );
  }
}

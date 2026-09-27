import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_provider_availability_header_section.dart';
import 'sections/scheduler_provider_availability_calendar_controls_section.dart';
import 'sections/scheduler_provider_availability_schedule_list_section.dart';
import 'sections/scheduler_provider_availability_appointment_details_section.dart';
import 'sections/scheduler_provider_availability_action_bar_section.dart';

class SchedulerProviderAvailabilityScreen extends StatelessWidget {
  const SchedulerProviderAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_provider_availability',
      title: 'SchedulerProviderAvailabilityScreen',
      child: Column(
        children: const [
          const SchedulerProviderAvailabilityHeaderSection(),
          const SchedulerProviderAvailabilityCalendarControlsSection(),
          const SchedulerProviderAvailabilityScheduleListSection(),
          const SchedulerProviderAvailabilityAppointmentDetailsSection(),
          const SchedulerProviderAvailabilityActionBarSection(),
        ],
      ),
    );
  }
}

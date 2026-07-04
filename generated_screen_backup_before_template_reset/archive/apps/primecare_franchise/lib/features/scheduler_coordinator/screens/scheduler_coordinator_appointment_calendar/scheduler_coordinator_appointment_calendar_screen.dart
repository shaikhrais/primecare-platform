import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_coordinator_appointment_calendar_header_section.dart';
import 'sections/scheduler_coordinator_appointment_calendar_calendar_controls_section.dart';
import 'sections/scheduler_coordinator_appointment_calendar_schedule_list_section.dart';
import 'sections/scheduler_coordinator_appointment_calendar_appointment_details_section.dart';
import 'sections/scheduler_coordinator_appointment_calendar_action_bar_section.dart';

class SchedulerCoordinatorAppointmentCalendarScreen extends StatelessWidget {
  const SchedulerCoordinatorAppointmentCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_coordinator_appointment_calendar',
      title: 'Scheduler Coordinator Appointment Calendar',
      child: Column(
        children: const [
          const SchedulerCoordinatorAppointmentCalendarHeaderSection(),
          const SchedulerCoordinatorAppointmentCalendarCalendarControlsSection(),
          const SchedulerCoordinatorAppointmentCalendarScheduleListSection(),
          const SchedulerCoordinatorAppointmentCalendarAppointmentDetailsSection(),
          const SchedulerCoordinatorAppointmentCalendarActionBarSection(),
        ],
      ),
    );
  }
}

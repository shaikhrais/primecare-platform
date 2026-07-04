import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_calendar_header_section.dart';
import 'sections/scheduler_calendar_calendar_controls_section.dart';
import 'sections/scheduler_calendar_schedule_list_section.dart';
import 'sections/scheduler_calendar_appointment_details_section.dart';
import 'sections/scheduler_calendar_action_bar_section.dart';

class SchedulerCalendarScreen extends StatelessWidget {
  const SchedulerCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_calendar',
      title: 'SchedulerCalendarScreen',
      child: Column(
        children: const [
          const SchedulerCalendarHeaderSection(),
          const SchedulerCalendarCalendarControlsSection(),
          const SchedulerCalendarScheduleListSection(),
          const SchedulerCalendarAppointmentDetailsSection(),
          const SchedulerCalendarActionBarSection(),
        ],
      ),
    );
  }
}

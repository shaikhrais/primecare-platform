import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/schedule_header_section.dart';
import 'sections/schedule_calendar_controls_section.dart';
import 'sections/schedule_schedule_list_section.dart';
import 'sections/schedule_appointment_details_section.dart';
import 'sections/schedule_action_bar_section.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'schedule',
      title: 'ScheduleScreen',
      child: Column(
        children: const [
          const ScheduleHeaderSection(),
          const ScheduleCalendarControlsSection(),
          const ScheduleScheduleListSection(),
          const ScheduleAppointmentDetailsSection(),
          const ScheduleActionBarSection(),
        ],
      ),
    );
  }
}

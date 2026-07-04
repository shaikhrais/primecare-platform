import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/calendar_management_header_section.dart';
import 'sections/calendar_management_calendar_controls_section.dart';
import 'sections/calendar_management_schedule_list_section.dart';
import 'sections/calendar_management_appointment_details_section.dart';
import 'sections/calendar_management_action_bar_section.dart';

class CalendarManagementScreen extends StatelessWidget {
  const CalendarManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'calendar_management',
      title: 'CalendarManagementScreen',
      child: Column(
        children: const [
          const CalendarManagementHeaderSection(),
          const CalendarManagementCalendarControlsSection(),
          const CalendarManagementScheduleListSection(),
          const CalendarManagementAppointmentDetailsSection(),
          const CalendarManagementActionBarSection(),
        ],
      ),
    );
  }
}

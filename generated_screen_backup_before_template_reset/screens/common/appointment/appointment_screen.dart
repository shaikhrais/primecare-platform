import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/appointment_header_section.dart';
import 'sections/appointment_calendar_controls_section.dart';
import 'sections/appointment_schedule_list_section.dart';
import 'sections/appointment_appointment_details_section.dart';
import 'sections/appointment_action_bar_section.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'appointment',
      title: 'AppointmentScreen',
      child: Column(
        children: const [
          const AppointmentHeaderSection(),
          const AppointmentCalendarControlsSection(),
          const AppointmentScheduleListSection(),
          const AppointmentAppointmentDetailsSection(),
          const AppointmentActionBarSection(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rmt_appointments_header_section.dart';
import 'sections/rmt_appointments_calendar_controls_section.dart';
import 'sections/rmt_appointments_schedule_list_section.dart';
import 'sections/rmt_appointments_appointment_details_section.dart';
import 'sections/rmt_appointments_action_bar_section.dart';

class RmtAppointmentsScreen extends StatelessWidget {
  const RmtAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rmt_appointments',
      title: 'RmtAppointmentsScreen',
      child: Column(
        children: const [
          const RmtAppointmentsHeaderSection(),
          const RmtAppointmentsCalendarControlsSection(),
          const RmtAppointmentsScheduleListSection(),
          const RmtAppointmentsAppointmentDetailsSection(),
          const RmtAppointmentsActionBarSection(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/chiropractor_appointments_header_section.dart';
import 'sections/chiropractor_appointments_calendar_controls_section.dart';
import 'sections/chiropractor_appointments_schedule_list_section.dart';
import 'sections/chiropractor_appointments_appointment_details_section.dart';
import 'sections/chiropractor_appointments_action_bar_section.dart';

class ChiropractorAppointmentsScreen extends StatelessWidget {
  const ChiropractorAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'chiropractor_appointments',
      title: 'ChiropractorAppointmentsScreen',
      child: Column(
        children: const [
          const ChiropractorAppointmentsHeaderSection(),
          const ChiropractorAppointmentsCalendarControlsSection(),
          const ChiropractorAppointmentsScheduleListSection(),
          const ChiropractorAppointmentsAppointmentDetailsSection(),
          const ChiropractorAppointmentsActionBarSection(),
        ],
      ),
    );
  }
}

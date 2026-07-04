import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/client_book_appointment_header_section.dart';
import 'sections/client_book_appointment_calendar_controls_section.dart';
import 'sections/client_book_appointment_schedule_list_section.dart';
import 'sections/client_book_appointment_appointment_details_section.dart';
import 'sections/client_book_appointment_action_bar_section.dart';

class ClientBookAppointmentScreen extends StatelessWidget {
  const ClientBookAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'client_book_appointment',
      title: 'Client Book Appointment',
      child: Column(
        children: const [
          const ClientBookAppointmentHeaderSection(),
          const ClientBookAppointmentCalendarControlsSection(),
          const ClientBookAppointmentScheduleListSection(),
          const ClientBookAppointmentAppointmentDetailsSection(),
          const ClientBookAppointmentActionBarSection(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/client_my_appointments_header_section.dart';
import 'sections/client_my_appointments_calendar_controls_section.dart';
import 'sections/client_my_appointments_schedule_list_section.dart';
import 'sections/client_my_appointments_appointment_details_section.dart';
import 'sections/client_my_appointments_action_bar_section.dart';

class ClientMyAppointmentsScreen extends StatelessWidget {
  const ClientMyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'client_my_appointments',
      title: 'Client My Appointments',
      child: Column(
        children: const [
          const ClientMyAppointmentsHeaderSection(),
          const ClientMyAppointmentsCalendarControlsSection(),
          const ClientMyAppointmentsScheduleListSection(),
          const ClientMyAppointmentsAppointmentDetailsSection(),
          const ClientMyAppointmentsActionBarSection(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/receptionist_appointments_header_section.dart';
import 'sections/receptionist_appointments_calendar_controls_section.dart';
import 'sections/receptionist_appointments_schedule_list_section.dart';
import 'sections/receptionist_appointments_appointment_details_section.dart';
import 'sections/receptionist_appointments_action_bar_section.dart';

class ReceptionistAppointmentsScreen extends StatelessWidget {
  const ReceptionistAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'receptionist_appointments',
      title: 'Receptionist Appointments',
      child: Column(
        children: const [
          const ReceptionistAppointmentsHeaderSection(),
          const ReceptionistAppointmentsCalendarControlsSection(),
          const ReceptionistAppointmentsScheduleListSection(),
          const ReceptionistAppointmentsAppointmentDetailsSection(),
          const ReceptionistAppointmentsActionBarSection(),
        ],
      ),
    );
  }
}

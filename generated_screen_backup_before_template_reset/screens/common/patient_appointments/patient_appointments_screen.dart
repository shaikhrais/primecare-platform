import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_appointments_header_section.dart';
import 'sections/patient_appointments_calendar_controls_section.dart';
import 'sections/patient_appointments_schedule_list_section.dart';
import 'sections/patient_appointments_appointment_details_section.dart';
import 'sections/patient_appointments_action_bar_section.dart';

class PatientAppointmentsScreen extends StatelessWidget {
  const PatientAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_appointments',
      title: 'PatientAppointmentsScreen',
      child: Column(
        children: const [
          const PatientAppointmentsHeaderSection(),
          const PatientAppointmentsCalendarControlsSection(),
          const PatientAppointmentsScheduleListSection(),
          const PatientAppointmentsAppointmentDetailsSection(),
          const PatientAppointmentsActionBarSection(),
        ],
      ),
    );
  }
}

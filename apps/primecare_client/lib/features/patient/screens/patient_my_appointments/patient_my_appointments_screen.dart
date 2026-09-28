import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_my_appointments_header_section.dart';
import 'sections/patient_my_appointments_calendar_controls_section.dart';
import 'sections/patient_my_appointments_schedule_list_section.dart';
import 'sections/patient_my_appointments_appointment_details_section.dart';
import 'sections/patient_my_appointments_action_bar_section.dart';

class PatientMyAppointmentsScreen extends StatelessWidget {
  const PatientMyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_my_appointments',
      title: 'Patient My Appointments',
      child: Column(
        children: const [
          const PatientMyAppointmentsHeaderSection(),
          const PatientMyAppointmentsCalendarControlsSection(),
          const PatientMyAppointmentsScheduleListSection(),
          const PatientMyAppointmentsAppointmentDetailsSection(),
          const PatientMyAppointmentsActionBarSection(),
        ],
      ),
    );
  }
}

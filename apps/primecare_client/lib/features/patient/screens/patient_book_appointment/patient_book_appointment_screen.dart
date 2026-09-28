import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/patient_book_appointment_header_section.dart';
import 'sections/patient_book_appointment_calendar_controls_section.dart';
import 'sections/patient_book_appointment_schedule_list_section.dart';
import 'sections/patient_book_appointment_appointment_details_section.dart';
import 'sections/patient_book_appointment_action_bar_section.dart';

class PatientBookAppointmentScreen extends StatelessWidget {
  const PatientBookAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'patient_book_appointment',
      title: 'Patient Book Appointment',
      child: Column(
        children: const [
          const PatientBookAppointmentHeaderSection(),
          const PatientBookAppointmentCalendarControlsSection(),
          const PatientBookAppointmentScheduleListSection(),
          const PatientBookAppointmentAppointmentDetailsSection(),
          const PatientBookAppointmentActionBarSection(),
        ],
      ),
    );
  }
}

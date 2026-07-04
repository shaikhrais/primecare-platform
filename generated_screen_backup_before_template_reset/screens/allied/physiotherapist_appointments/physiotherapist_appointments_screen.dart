import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/physiotherapist_appointments_header_section.dart';
import 'sections/physiotherapist_appointments_calendar_controls_section.dart';
import 'sections/physiotherapist_appointments_schedule_list_section.dart';
import 'sections/physiotherapist_appointments_appointment_details_section.dart';
import 'sections/physiotherapist_appointments_action_bar_section.dart';

class PhysiotherapistAppointmentsScreen extends StatelessWidget {
  const PhysiotherapistAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'physiotherapist_appointments',
      title: 'PhysiotherapistAppointmentsScreen',
      child: Column(
        children: const [
          const PhysiotherapistAppointmentsHeaderSection(),
          const PhysiotherapistAppointmentsCalendarControlsSection(),
          const PhysiotherapistAppointmentsScheduleListSection(),
          const PhysiotherapistAppointmentsAppointmentDetailsSection(),
          const PhysiotherapistAppointmentsActionBarSection(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/receptionist_visitors_header_section.dart';
import 'sections/receptionist_visitors_calendar_controls_section.dart';
import 'sections/receptionist_visitors_schedule_list_section.dart';
import 'sections/receptionist_visitors_appointment_details_section.dart';
import 'sections/receptionist_visitors_action_bar_section.dart';

class ReceptionistVisitorsScreen extends StatelessWidget {
  const ReceptionistVisitorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'receptionist_visitors',
      title: 'Receptionist Visitors',
      child: Column(
        children: const [
          const ReceptionistVisitorsHeaderSection(),
          const ReceptionistVisitorsCalendarControlsSection(),
          const ReceptionistVisitorsScheduleListSection(),
          const ReceptionistVisitorsAppointmentDetailsSection(),
          const ReceptionistVisitorsActionBarSection(),
        ],
      ),
    );
  }
}

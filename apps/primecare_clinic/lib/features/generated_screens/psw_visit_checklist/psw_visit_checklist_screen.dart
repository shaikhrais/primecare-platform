import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_visit_checklist_header_section.dart';
import 'sections/psw_visit_checklist_calendar_controls_section.dart';
import 'sections/psw_visit_checklist_schedule_list_section.dart';
import 'sections/psw_visit_checklist_appointment_details_section.dart';
import 'sections/psw_visit_checklist_action_bar_section.dart';

class PswVisitChecklistScreen extends StatelessWidget {
  const PswVisitChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_visit_checklist',
      title: 'Psw Visit Checklist',
      child: Column(
        children: const [
          const PswVisitChecklistHeaderSection(),
          const PswVisitChecklistCalendarControlsSection(),
          const PswVisitChecklistScheduleListSection(),
          const PswVisitChecklistAppointmentDetailsSection(),
          const PswVisitChecklistActionBarSection(),
        ],
      ),
    );
  }
}

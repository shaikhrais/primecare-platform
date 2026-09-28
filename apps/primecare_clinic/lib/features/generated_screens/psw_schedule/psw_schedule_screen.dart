import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_schedule_header_section.dart';
import 'sections/psw_schedule_calendar_controls_section.dart';
import 'sections/psw_schedule_schedule_list_section.dart';
import 'sections/psw_schedule_appointment_details_section.dart';
import 'sections/psw_schedule_action_bar_section.dart';

class PswScheduleScreen extends StatelessWidget {
  const PswScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_schedule',
      title: 'Psw Schedule',
      child: Column(
        children: const [
          const PswScheduleHeaderSection(),
          const PswScheduleCalendarControlsSection(),
          const PswScheduleScheduleListSection(),
          const PswScheduleAppointmentDetailsSection(),
          const PswScheduleActionBarSection(),
        ],
      ),
    );
  }
}

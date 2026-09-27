import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/caregiver_schedule_header_section.dart';
import 'sections/caregiver_schedule_calendar_controls_section.dart';
import 'sections/caregiver_schedule_schedule_list_section.dart';
import 'sections/caregiver_schedule_appointment_details_section.dart';
import 'sections/caregiver_schedule_action_bar_section.dart';

class CaregiverScheduleScreen extends StatelessWidget {
  const CaregiverScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'caregiver_schedule',
      title: 'CaregiverScheduleScreen',
      child: Column(
        children: const [
          const CaregiverScheduleHeaderSection(),
          const CaregiverScheduleCalendarControlsSection(),
          const CaregiverScheduleScheduleListSection(),
          const CaregiverScheduleAppointmentDetailsSection(),
          const CaregiverScheduleActionBarSection(),
        ],
      ),
    );
  }
}

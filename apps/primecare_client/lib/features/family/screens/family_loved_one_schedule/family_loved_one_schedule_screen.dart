import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/family_loved_one_schedule_header_section.dart';
import 'sections/family_loved_one_schedule_calendar_controls_section.dart';
import 'sections/family_loved_one_schedule_schedule_list_section.dart';
import 'sections/family_loved_one_schedule_appointment_details_section.dart';
import 'sections/family_loved_one_schedule_action_bar_section.dart';

class FamilyLovedOneScheduleScreen extends StatelessWidget {
  const FamilyLovedOneScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'family_loved_one_schedule',
      title: 'Family Loved One Schedule',
      child: Column(
        children: const [
          const FamilyLovedOneScheduleHeaderSection(),
          const FamilyLovedOneScheduleCalendarControlsSection(),
          const FamilyLovedOneScheduleScheduleListSection(),
          const FamilyLovedOneScheduleAppointmentDetailsSection(),
          const FamilyLovedOneScheduleActionBarSection(),
        ],
      ),
    );
  }
}

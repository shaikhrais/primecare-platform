import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/family_member_loved_one_schedule_header_section.dart';
import 'sections/family_member_loved_one_schedule_calendar_controls_section.dart';
import 'sections/family_member_loved_one_schedule_schedule_list_section.dart';
import 'sections/family_member_loved_one_schedule_appointment_details_section.dart';
import 'sections/family_member_loved_one_schedule_action_bar_section.dart';

class FamilyMemberLovedOneScheduleScreen extends StatelessWidget {
  const FamilyMemberLovedOneScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'family_member_loved_one_schedule',
      title: 'Family Member Loved One Schedule',
      child: Column(
        children: const [
          const FamilyMemberLovedOneScheduleHeaderSection(),
          const FamilyMemberLovedOneScheduleCalendarControlsSection(),
          const FamilyMemberLovedOneScheduleScheduleListSection(),
          const FamilyMemberLovedOneScheduleAppointmentDetailsSection(),
          const FamilyMemberLovedOneScheduleActionBarSection(),
        ],
      ),
    );
  }
}

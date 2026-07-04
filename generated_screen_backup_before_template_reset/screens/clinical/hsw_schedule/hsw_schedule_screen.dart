import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hsw_schedule_header_section.dart';
import 'sections/hsw_schedule_calendar_controls_section.dart';
import 'sections/hsw_schedule_schedule_list_section.dart';
import 'sections/hsw_schedule_appointment_details_section.dart';
import 'sections/hsw_schedule_action_bar_section.dart';

class HswScheduleScreen extends StatelessWidget {
  const HswScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hsw_schedule',
      title: 'HswScheduleScreen',
      child: Column(
        children: const [
          const HswScheduleHeaderSection(),
          const HswScheduleCalendarControlsSection(),
          const HswScheduleScheduleListSection(),
          const HswScheduleAppointmentDetailsSection(),
          const HswScheduleActionBarSection(),
        ],
      ),
    );
  }
}

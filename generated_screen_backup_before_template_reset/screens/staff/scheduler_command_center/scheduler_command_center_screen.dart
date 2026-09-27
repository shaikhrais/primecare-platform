import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_command_center_header_section.dart';
import 'sections/scheduler_command_center_calendar_controls_section.dart';
import 'sections/scheduler_command_center_schedule_list_section.dart';
import 'sections/scheduler_command_center_appointment_details_section.dart';
import 'sections/scheduler_command_center_action_bar_section.dart';

class SchedulerCommandCenterScreen extends StatelessWidget {
  const SchedulerCommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_command_center',
      title: 'SchedulerCommandCenterScreen',
      child: Column(
        children: const [
          const SchedulerCommandCenterHeaderSection(),
          const SchedulerCommandCenterCalendarControlsSection(),
          const SchedulerCommandCenterScheduleListSection(),
          const SchedulerCommandCenterAppointmentDetailsSection(),
          const SchedulerCommandCenterActionBarSection(),
        ],
      ),
    );
  }
}

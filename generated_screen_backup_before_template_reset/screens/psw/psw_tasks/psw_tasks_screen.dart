import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_tasks_header_section.dart';
import 'sections/psw_tasks_calendar_controls_section.dart';
import 'sections/psw_tasks_schedule_list_section.dart';
import 'sections/psw_tasks_appointment_details_section.dart';
import 'sections/psw_tasks_action_bar_section.dart';

class PswTasksScreen extends StatelessWidget {
  const PswTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_tasks',
      title: 'Task List',
      child: Column(
        children: const [
          const PswTasksHeaderSection(),
          const PswTasksCalendarControlsSection(),
          const PswTasksScheduleListSection(),
          const PswTasksAppointmentDetailsSection(),
          const PswTasksActionBarSection(),
        ],
      ),
    );
  }
}

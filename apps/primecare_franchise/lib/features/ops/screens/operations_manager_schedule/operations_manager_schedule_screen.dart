import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/operations_manager_schedule_header_section.dart';
import 'sections/operations_manager_schedule_calendar_controls_section.dart';
import 'sections/operations_manager_schedule_schedule_list_section.dart';
import 'sections/operations_manager_schedule_appointment_details_section.dart';
import 'sections/operations_manager_schedule_action_bar_section.dart';

class OperationsManagerScheduleScreen extends StatelessWidget {
  const OperationsManagerScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'operations_manager_schedule',
      title: 'Operations Manager Schedule',
      child: Column(
        children: const [
          const OperationsManagerScheduleHeaderSection(),
          const OperationsManagerScheduleCalendarControlsSection(),
          const OperationsManagerScheduleScheduleListSection(),
          const OperationsManagerScheduleAppointmentDetailsSection(),
          const OperationsManagerScheduleActionBarSection(),
        ],
      ),
    );
  }
}

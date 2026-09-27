import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_coordinator_shift_calendar_header_section.dart';
import 'sections/scheduler_coordinator_shift_calendar_calendar_controls_section.dart';
import 'sections/scheduler_coordinator_shift_calendar_schedule_list_section.dart';
import 'sections/scheduler_coordinator_shift_calendar_appointment_details_section.dart';
import 'sections/scheduler_coordinator_shift_calendar_action_bar_section.dart';

class SchedulerCoordinatorShiftCalendarScreen extends StatelessWidget {
  const SchedulerCoordinatorShiftCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_coordinator_shift_calendar',
      title: 'Scheduler Coordinator Shift Calendar',
      child: Column(
        children: const [
          const SchedulerCoordinatorShiftCalendarHeaderSection(),
          const SchedulerCoordinatorShiftCalendarCalendarControlsSection(),
          const SchedulerCoordinatorShiftCalendarScheduleListSection(),
          const SchedulerCoordinatorShiftCalendarAppointmentDetailsSection(),
          const SchedulerCoordinatorShiftCalendarActionBarSection(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_analytics_header_section.dart';
import 'sections/scheduler_analytics_calendar_controls_section.dart';
import 'sections/scheduler_analytics_schedule_list_section.dart';
import 'sections/scheduler_analytics_appointment_details_section.dart';
import 'sections/scheduler_analytics_action_bar_section.dart';

class SchedulerAnalyticsScreen extends StatelessWidget {
  const SchedulerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_analytics',
      title: 'SchedulerAnalyticsScreen',
      child: Column(
        children: const [
          const SchedulerAnalyticsHeaderSection(),
          const SchedulerAnalyticsCalendarControlsSection(),
          const SchedulerAnalyticsScheduleListSection(),
          const SchedulerAnalyticsAppointmentDetailsSection(),
          const SchedulerAnalyticsActionBarSection(),
        ],
      ),
    );
  }
}

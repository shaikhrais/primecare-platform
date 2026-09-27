import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/appointment_overview_header_section.dart';
import 'sections/appointment_overview_calendar_controls_section.dart';
import 'sections/appointment_overview_schedule_list_section.dart';
import 'sections/appointment_overview_appointment_details_section.dart';
import 'sections/appointment_overview_action_bar_section.dart';

class AppointmentOverviewScreen extends StatelessWidget {
  const AppointmentOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'appointment_overview',
      title: 'AppointmentOverviewScreen',
      child: Column(
        children: const [
          const AppointmentOverviewHeaderSection(),
          const AppointmentOverviewCalendarControlsSection(),
          const AppointmentOverviewScheduleListSection(),
          const AppointmentOverviewAppointmentDetailsSection(),
          const AppointmentOverviewActionBarSection(),
        ],
      ),
    );
  }
}

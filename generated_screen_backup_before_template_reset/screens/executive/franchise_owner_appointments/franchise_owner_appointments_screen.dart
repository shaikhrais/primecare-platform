import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/franchise_owner_appointments_header_section.dart';
import 'sections/franchise_owner_appointments_calendar_controls_section.dart';
import 'sections/franchise_owner_appointments_schedule_list_section.dart';
import 'sections/franchise_owner_appointments_appointment_details_section.dart';
import 'sections/franchise_owner_appointments_action_bar_section.dart';

class FranchiseOwnerAppointmentsScreen extends StatelessWidget {
  const FranchiseOwnerAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'franchise_owner_appointments',
      title: 'FranchiseOwnerAppointmentsScreen',
      child: Column(
        children: const [
          const FranchiseOwnerAppointmentsHeaderSection(),
          const FranchiseOwnerAppointmentsCalendarControlsSection(),
          const FranchiseOwnerAppointmentsScheduleListSection(),
          const FranchiseOwnerAppointmentsAppointmentDetailsSection(),
          const FranchiseOwnerAppointmentsActionBarSection(),
        ],
      ),
    );
  }
}

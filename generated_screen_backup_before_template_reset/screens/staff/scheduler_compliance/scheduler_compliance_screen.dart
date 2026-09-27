import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/scheduler_compliance_header_section.dart';
import 'sections/scheduler_compliance_calendar_controls_section.dart';
import 'sections/scheduler_compliance_schedule_list_section.dart';
import 'sections/scheduler_compliance_appointment_details_section.dart';
import 'sections/scheduler_compliance_action_bar_section.dart';

class SchedulerComplianceScreen extends StatelessWidget {
  const SchedulerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'scheduler_compliance',
      title: 'SchedulerComplianceScreen',
      child: Column(
        children: const [
          const SchedulerComplianceHeaderSection(),
          const SchedulerComplianceCalendarControlsSection(),
          const SchedulerComplianceScheduleListSection(),
          const SchedulerComplianceAppointmentDetailsSection(),
          const SchedulerComplianceActionBarSection(),
        ],
      ),
    );
  }
}

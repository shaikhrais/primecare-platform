import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/simulation_lab_scheduler_header_section.dart';
import 'sections/simulation_lab_scheduler_calendar_controls_section.dart';
import 'sections/simulation_lab_scheduler_schedule_list_section.dart';
import 'sections/simulation_lab_scheduler_appointment_details_section.dart';
import 'sections/simulation_lab_scheduler_action_bar_section.dart';

class SimulationLabSchedulerScreen extends StatelessWidget {
  const SimulationLabSchedulerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'simulation_lab_scheduler',
      title: 'Simulation Lab Scheduler',
      child: Column(
        children: const [
          const SimulationLabSchedulerHeaderSection(),
          const SimulationLabSchedulerCalendarControlsSection(),
          const SimulationLabSchedulerScheduleListSection(),
          const SimulationLabSchedulerAppointmentDetailsSection(),
          const SimulationLabSchedulerActionBarSection(),
        ],
      ),
    );
  }
}

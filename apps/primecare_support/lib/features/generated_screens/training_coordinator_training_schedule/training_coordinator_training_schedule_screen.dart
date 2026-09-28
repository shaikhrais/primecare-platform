import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_coordinator_training_schedule_header_section.dart';
import 'sections/training_coordinator_training_schedule_calendar_controls_section.dart';
import 'sections/training_coordinator_training_schedule_schedule_list_section.dart';
import 'sections/training_coordinator_training_schedule_appointment_details_section.dart';
import 'sections/training_coordinator_training_schedule_action_bar_section.dart';

class TrainingCoordinatorTrainingScheduleScreen extends StatelessWidget {
  const TrainingCoordinatorTrainingScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_coordinator_training_schedule',
      title: 'Training Coordinator Training Schedule',
      child: Column(
        children: const [
          const TrainingCoordinatorTrainingScheduleHeaderSection(),
          const TrainingCoordinatorTrainingScheduleCalendarControlsSection(),
          const TrainingCoordinatorTrainingScheduleScheduleListSection(),
          const TrainingCoordinatorTrainingScheduleAppointmentDetailsSection(),
          const TrainingCoordinatorTrainingScheduleActionBarSection(),
        ],
      ),
    );
  }
}

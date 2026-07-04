import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/training_coordinator_attendance_header_section.dart';
import 'sections/training_coordinator_attendance_content_summary_section.dart';
import 'sections/training_coordinator_attendance_primary_content_section.dart';
import 'sections/training_coordinator_attendance_action_bar_section.dart';

class TrainingCoordinatorAttendanceScreen extends StatelessWidget {
  const TrainingCoordinatorAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'training_coordinator_attendance',
      title: 'Training Coordinator Attendance',
      child: Column(
        children: const [
          const TrainingCoordinatorAttendanceHeaderSection(),
          const TrainingCoordinatorAttendanceContentSummarySection(),
          const TrainingCoordinatorAttendancePrimaryContentSection(),
          const TrainingCoordinatorAttendanceActionBarSection(),
        ],
      ),
    );
  }
}

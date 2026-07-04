import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/operations_manager_attendance_header_section.dart';
import 'sections/operations_manager_attendance_content_summary_section.dart';
import 'sections/operations_manager_attendance_primary_content_section.dart';
import 'sections/operations_manager_attendance_action_bar_section.dart';

class OperationsManagerAttendanceScreen extends StatelessWidget {
  const OperationsManagerAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'operations_manager_attendance',
      title: 'Operations Manager Attendance',
      child: Column(
        children: const [
          const OperationsManagerAttendanceHeaderSection(),
          const OperationsManagerAttendanceContentSummarySection(),
          const OperationsManagerAttendancePrimaryContentSection(),
          const OperationsManagerAttendanceActionBarSection(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/attendance_header_section.dart';
import 'sections/attendance_content_summary_section.dart';
import 'sections/attendance_primary_content_section.dart';
import 'sections/attendance_action_bar_section.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'attendance',
      title: 'AttendanceScreen',
      child: Column(
        children: const [
          const AttendanceHeaderSection(),
          const AttendanceContentSummarySection(),
          const AttendancePrimaryContentSection(),
          const AttendanceActionBarSection(),
        ],
      ),
    );
  }
}

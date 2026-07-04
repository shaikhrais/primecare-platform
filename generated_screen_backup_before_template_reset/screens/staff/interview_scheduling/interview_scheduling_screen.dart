import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/interview_scheduling_header_section.dart';
import 'sections/interview_scheduling_filter_bar_section.dart';
import 'sections/interview_scheduling_data_table_section.dart';
import 'sections/interview_scheduling_pagination_section.dart';
import 'sections/interview_scheduling_action_bar_section.dart';

class InterviewSchedulingScreen extends StatelessWidget {
  const InterviewSchedulingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'interview_scheduling',
      title: 'InterviewSchedulingScreen',
      child: Column(
        children: const [
          const InterviewSchedulingHeaderSection(),
          const InterviewSchedulingFilterBarSection(),
          const InterviewSchedulingDataTableSection(),
          const InterviewSchedulingPaginationSection(),
          const InterviewSchedulingActionBarSection(),
        ],
      ),
    );
  }
}

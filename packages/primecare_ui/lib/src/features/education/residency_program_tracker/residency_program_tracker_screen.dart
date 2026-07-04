import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/residency_program_tracker_header_section.dart';
import 'sections/residency_program_tracker_content_summary_section.dart';
import 'sections/residency_program_tracker_primary_content_section.dart';
import 'sections/residency_program_tracker_action_bar_section.dart';

class ResidencyProgramTrackerScreen extends StatelessWidget {
  const ResidencyProgramTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'residency_program_tracker',
      title: 'Residency Program Tracker',
      child: Column(
        children: const [
          const ResidencyProgramTrackerHeaderSection(),
          const ResidencyProgramTrackerContentSummarySection(),
          const ResidencyProgramTrackerPrimaryContentSection(),
          const ResidencyProgramTrackerActionBarSection(),
        ],
      ),
    );
  }
}

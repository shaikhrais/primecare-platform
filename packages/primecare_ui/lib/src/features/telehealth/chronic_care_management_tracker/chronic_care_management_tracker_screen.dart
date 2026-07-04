import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/chronic_care_management_tracker_header_section.dart';
import 'sections/chronic_care_management_tracker_content_summary_section.dart';
import 'sections/chronic_care_management_tracker_primary_content_section.dart';
import 'sections/chronic_care_management_tracker_action_bar_section.dart';

class ChronicCareManagementTrackerScreen extends StatelessWidget {
  const ChronicCareManagementTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'chronic_care_management_tracker',
      title: 'Chronic Care Management Tracker',
      child: Column(
        children: const [
          const ChronicCareManagementTrackerHeaderSection(),
          const ChronicCareManagementTrackerContentSummarySection(),
          const ChronicCareManagementTrackerPrimaryContentSection(),
          const ChronicCareManagementTrackerActionBarSection(),
        ],
      ),
    );
  }
}

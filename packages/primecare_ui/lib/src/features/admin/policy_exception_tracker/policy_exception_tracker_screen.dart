import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/policy_exception_tracker_header_section.dart';
import 'sections/policy_exception_tracker_content_summary_section.dart';
import 'sections/policy_exception_tracker_primary_content_section.dart';
import 'sections/policy_exception_tracker_action_bar_section.dart';

class PolicyExceptionTrackerScreen extends StatelessWidget {
  const PolicyExceptionTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'policy_exception_tracker',
      title: 'Policy Exception Tracker',
      child: Column(
        children: const [
          const PolicyExceptionTrackerHeaderSection(),
          const PolicyExceptionTrackerContentSummarySection(),
          const PolicyExceptionTrackerPrimaryContentSection(),
          const PolicyExceptionTrackerActionBarSection(),
        ],
      ),
    );
  }
}
